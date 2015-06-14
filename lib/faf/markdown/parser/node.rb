

module FAF
  module Markdown
    class Node
      include Helpers
      def initialize(data = [])
        @data = data
      end

      def process_children(processor)
        @data = processor.call(@data)
        self
      end

      def to_s
        @data.join
      end

      def self.match_chars
        %w()
      end

    end
  end
end
