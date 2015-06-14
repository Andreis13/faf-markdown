

require 'faf/markdown/parser/processor'

module FAF
  module Markdown
    class BinaryProcessor < Processor

      def call(data)
        @data = data
        @result = []
        @temp_data = nil
        @current_state = look_for_start

        while item = @data.shift
          @current_state.call(item)
        end

        @result += [self.class.match_chars.first] + @temp_data if @temp_data
        @result = next_processor.call(@result) if next_processor
        @result
      end


      def look_for_start
        Proc.new do |item|
          if item == match_chars.first
            @temp_data = []
            @current_state = look_for_end
          else
            @result << item
          end
        end
      end

      def look_for_end
        Proc.new do |item|
          if item == match_chars.first
            node = associated_node_class.new(@temp_data)
            node.process_children(next_processor) if next_processor
            @result << node
            @temp_data = nil
            @current_state = look_for_start
          else
            @temp_data << item
          end
        end
      end

      def associated_node_class
        self.class.associated_node_class
      end

      def self.associated_node_class
        raise NotImplementedError.new("This method must return the class of the Node that should be created by the processor")
      end

    end
  end
end



