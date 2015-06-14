module FAF
  module Markdown
    module Helpers

      def content_tag(name, content = nil, opts = {})
        "<#{name}#{tag_options(opts)}>#{content}</#{name}>"
      end

      def tag_options(hash)
        hash.to_a.map{ |pair| " #{tag_option(*pair)}" }.join
      end

      def tag_option(key, value)
        val = value.is_a?(Array) ? value.join(' ') : value
        %(#{key}="#{val}")
      end

    end
  end
end
