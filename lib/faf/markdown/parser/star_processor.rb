
require 'faf/markdown/parser/processor'
require 'faf/markdown/parser/strong_node'
require 'faf/markdown/parser/emph_node'

module FAF
  module Markdown
    class StarProcessor < Processor
      def self.match_chars
        %w(*** ** *)
      end

      def call(data)
        @stacks = [[]]

        @current_state = check_if_star

        while item = data.shift
          @current_state.call(item)
        end

        @stacks.flatten
      end

      def check_if_star
        proc do |item|
          case item
          when '*'
            if one_star_tag_opened?
              close_one_star_tag!
            else
              open_one_star_tag!
            end
          when '**'
            if two_star_tag_opened?
              close_two_star_tag!
            else
              open_two_star_tag!
            end
          when '***'
            if one_star_tag_opened?
              close_one_star_tag!
              close_two_star_tag! if two_star_tag_opened?
            elsif two_star_tag_opened?
              close_two_star_tag!
              close_one_star_tag! if one_star_tag_opened?
            end
          else
            @stacks.last.push(item)
          end
        end
      end

      def check_if_2_stars
        proc do |item|
          if item == '*'
            if two_star_tag_opened?
              close_two_star_tag!
            else
              open_two_star_tag!
            end
          else
            if one_star_tag_opened?
              close_one_star_tag!
            else
              open_one_star_tag!
              @stacks.last.push(item) if item
            end
          end

          @current_state = check_if_star
        end
      end

      def one_star_tag_opened?
        '*' == @stacks.last.take(1).join
      end

      def two_star_tag_opened?
        '**' == @stacks.last.take(1).join
      end

      def open_one_star_tag!
        @stacks.push ['*']
      end

      def open_two_star_tag!
        @stacks.push ['**']
      end

      def close_one_star_tag!
        data = @stacks.pop
        node = EmphNode.new(data.drop(1))
        node.process_childern(next_processor) if next_processor
        @stacks.last.push(node)
      end

      def close_two_star_tag!
        data = @stacks.pop
        node = StrongNode.new(data.drop(1))
        node.process_childern(next_processor) if next_processor
        @stacks.last.push(node)
      end
    end
  end
end
