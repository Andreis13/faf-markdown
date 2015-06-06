
require 'sinatra'

module FAF
  module Markdown
    class App < Sinatra::Application
      get '/' do
        'it works!'
      end
    end
  end
end
