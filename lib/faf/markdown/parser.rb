require 'faf/markdown/helpers'
require 'faf/markdown/parser/nodes'
require 'faf/markdown/parser/processors'
require 'faf/markdown/parser/processing_chain'

module FAF
  module Markdown
    class Parser
      include Helpers

      def initialize(string)
        @input_data = string
      end

      def run
        split_top_level(@input_data).map do |itm|
          if md = itm.match(/\#{1,6}/)
            content_tag("h#{md[0].size}", process_top_level(itm.sub(/\#{1,6}\s*/, '')))
          else
            content_tag('p', process_top_level(itm))
          end
        end.join("\n\n")
      end

      private

      def split_top_level(string)
        string.lines.slice_when do |line1, line2|
          line1.match(/\#{1,6}/) || line1.chomp.empty? ||
            line2.match(/\#{1,6}/) || line2.chomp.empty?
        end.map do |group|
          group.reject { |itm| itm.chomp.empty? }.join.chomp
        end.reject(&:empty?)
      end

      def process_top_level(string)
        special_chars = [
          FAF::Markdown::LinkProcessor,
          FAF::Markdown::CodeProcessor,
          FAF::Markdown::StarProcessor
        ].flat_map(&:match_chars)

        data = split_by_special_chars(string, special_chars)

        pc = ProcessingChain.new
        pc << FAF::Markdown::LinkProcessor.new
        pc << FAF::Markdown::CodeProcessor.new
        pc << FAF::Markdown::StarProcessor.new
        node = Node.new(data).process_children(pc.start)
        node.to_s
      end

      def split_by_special_chars(string, chars)
        escaped = chars.map { |s| Regexp.quote s }
        r = Regexp.new("(#{escaped.join('|')})")

        data = []
        until string.empty?
          head, match, tail = string.partition(r)
          data << head unless head.empty?
          data << match
          string = tail
        end
        data.reject(&:empty?)
      end
    end
  end
end
