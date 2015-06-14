
require 'sinatra'
require 'haml'
require 'faf/markdown/parser'
require 'net/http'

module FAF
  module Markdown
    class App < Sinatra::Application
      get '/' do
        haml :form, :layout => :layout
      end

      post '/' do
        url = params[:url]
        uri = URI(url)
        input = Net::HTTP.get(uri)
        @data = Parser.new(input).run
        haml :result, :layout => :layout
      end

      helpers do
        def h(text)
          Rack::Utils.escape_html(text)
        end
      end
    end
  end
end

__END__

@@layout
!!!
%html
  %head
    %title FAF Markdown
    %link{ rel: 'stylesheet', href: 'https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css' }
    /%script{ src: 'https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js' }
    :css
      .vertical-align {
          display: flex;
          align-items: center;
      }
  %body
    .container
      .row
        .col-xs-12
          = yield

@@form
%br
.panel.panel-default
  .panel-body
    %form{method: 'POST'}
      .form-group
        %input.form-control{ type: 'text', name: 'url' }
      .form-group
        %input.btn.btn-primary{ type: 'submit' }

@@result
%br
.panel.panel-default
  .panel-body
    .row
      .col-md-6
        = @data
      .col-md-6
        %pre= h @data
