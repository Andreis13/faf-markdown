
require 'optparse'

module FAF
  module Markdown
    class CliOptions
      attr_reader :url, :file

      def initialize(args)
        parser = OptionParser.new(args) do |opts|
          opts.on '--url=URL' do |u|
            @url = u
          end

          opts.on '--file=FILE' do |f|
            @file = f
          end
        end

        parser.parse!(args)
      end
    end
  end
end
