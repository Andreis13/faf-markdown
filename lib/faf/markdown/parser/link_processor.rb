
require 'faf/markdown/parser/processor'

require 'faf/markdown/parser/link_node'

module FAF
  module Markdown
    class LinkProcessor < Processor

      def call(data)
        @data = data
        @result = []
        @text_data = @url_data = nil
        @current_state = look_for_start

        while item = @data.shift
          @current_state.call(item)
        end

        @result += @temp_link.unwind if @temp_link
        @result = next_processor.call(@result) if next_processor
        @result
      end

      def look_for_start
        @look_for_start ||= Proc.new do |item|
          if item == '['
            @text_data = []
            @current_state = look_for_middle
          else
            @result << item
          end
        end
      end

      def look_for_middle
        @look_for_middle ||= Proc.new do |item|
          if item == ']('
            @url_data = []
            @current_state = look_for_end
          else
            @text_data << item
          end
        end
      end

      def look_for_end
        @look_for_end ||= Proc.new do |item|
          if item == ')'
            link = LinkNode.new(@text_data, @url_data).process_children(next_processor)
            @result << link
            @text_data = @url_data = nil
            @current_state = look_for_start
          else
            @url_data << item
          end
        end
      end

      def self.match_chars
        %w([ ]( ))
      end
    end
  end
end
