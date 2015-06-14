
require 'faf/markdown/parser/node'

module FAF
  module Markdown
    class LinkNode < Node
      attr_reader :text, :url
      def initialize(text, url)
        super(text)
        @url = url
      end

      def inspect
        content_tag(:a, @data.join, href: @url.join)
      end

      def to_s
        inspect
      end

      def self.match_chars
        %w([ ]( ))
      end
    end
  end
end
