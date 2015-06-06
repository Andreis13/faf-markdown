module FAF
  module Markdown
    module Helpers

      def content_tag(name, content=nil)
        "<#{name}>#{content}</#{name}>"
      end

      def split_top_level(string)
        string.lines.slice_when do |line1, line2|
          line1.match(/\#{1,6}\s+.+$/) || line1.chomp.empty? ||
            line2.match(/\#{1,6}\s+.+$/) || line2.chomp.empty?
        end.map do |group|
          group.reject { |itm| itm.chomp.empty? }.join.chomp
        end.reject(&:empty?)
      end

      def tag_options(hash)
        hash.to_a.map{ |pair| tag_option(*pair) }.join(' ')
      end

      def tag_option(key, value)
        val = value.is_a?(Array) ? value.join(' ') : value
        %(#{key}="#{val}")
      end

    end
  end
end
