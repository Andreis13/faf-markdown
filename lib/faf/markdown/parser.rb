require 'faf/markdown/helpers'

module FAF
  module Markdown
    class Parser
      include Helpers

      def initialize(string)
        @input_data = string
      end

      def run
        split_top_level(@input_data).map do |itm|
          if md = itm.match(/^\s*(\#{1,6})\s+(.+)$/)
            content_tag("h#{md[1].size}", md[2])
          else
            content_tag('p', itm)
          end
        end.join("\n\n")
      end

      private

      def find_headings!

      end

      def split_paragraphs
      end
    end
  end
end
