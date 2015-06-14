
require 'faf/markdown/parser/binary_processor'
require 'faf/markdown/parser/strong_node'

module FAF
  module Markdown
    class StrongProcessor < BinaryProcessor
      def self.match_chars
        %w(**)
      end

      def self.associated_node_class
        StrongNode
      end
    end
  end
end
