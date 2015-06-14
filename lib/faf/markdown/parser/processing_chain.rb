

module FAF
  module Markdown
    class ProcessingChain
      def initialize
        @processors = []
      end

      def <<(p)
        @processors.last.next_processor = p unless @processors.empty?
        @processors.push(p)
        self
      end

      def start
        @processors.first
      end
    end
  end
end
