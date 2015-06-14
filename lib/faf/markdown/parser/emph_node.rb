
require 'faf/markdown/parser/simple_node'

module FAF
  module Markdown
    class EmphNode < SimpleNode
      def to_s
        content_tag(:em, @data.join)
      end
    end
  end
end
