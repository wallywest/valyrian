require 'sinatra/base'
require 'active_support/core_ext'
STDOUT.sync = true


class Valyrian::Service::App < Sinatra::Base
  get '/test' do
    status 200
  end

  get "/:app_id/events" do
    options = {}
    m = protocol.fetch_all(params[:app_id].to_i)
    json('events' => m)
  end

  get "/event/:oid" do
    event = protocol.fetch_event(params[:oid])
    json('events' => event)
  end

  get "/versions/:package_id" do
  end


  helpers do
    def json(object)
      content_type("application/json")
      MultiJson.encode(object)
    end

    def protocol
      Valyrian::Service::Protocol
    end
  end

  before do
    @timer = Time.now
  end

  after do
    time = "%.5fs" % [Time.now - @timer]
    puts "Time to execute #{time}"
  end

  disable :dump_errors
  disable :dump_exceptions

  error do
    exception = env["sinatra.error"]
    
    puts exception
    status 500
  end
end
