
require 'faf/markdown/parser/binary_processor'

module FAF
  module Markdown
    class CodeProcessor < BinaryProcessor
      def self.match_chars
        %w(`)
      end

      def self.associated_node_class
        CodeNode
      end
    end
  end
end
