
require 'faf/markdown/parser/processor'

module FAF
  module Markdown
    class EmphProcessor < BinaryProcessor
      def self.match_chars
        %w(*)
      end

      def self.associated_node_class
        EmphNode
      end
    end
  end
end
