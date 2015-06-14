
require 'faf/markdown/parser/simple_node'

module FAF
  module Markdown
    class StrongNode < SimpleNode
      def to_s
        content_tag(:strong, @data.join)
      end
    end
  end
end
