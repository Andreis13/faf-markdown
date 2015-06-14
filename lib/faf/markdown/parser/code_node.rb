
require 'faf/markdown/parser/simple_node'

module FAF
  module Markdown
    class CodeNode < SimpleNode
      def to_s
        content_tag(:code, @data.join)
      end
    end
  end
end
