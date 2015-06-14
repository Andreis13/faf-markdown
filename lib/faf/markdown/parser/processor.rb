
module FAF
  module Markdown
    class Processor

      attr_accessor :next_processor

      def call(data)
        data
      end

      def match_chars
        self.class.match_chars
      end

      def self.match_chars
        raise NotImplementedError.new
      end
    end
  end
end
