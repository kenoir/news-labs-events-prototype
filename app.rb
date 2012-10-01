require 'sinatra'
require 'sinatra/base'
require 'yaml'
require 'dalli'

Dir.glob("controllers/*.rb").each { |r| require_relative r }
Dir.glob("mixin/*.rb").each { |r| require_relative r }
Dir.glob("models/*.rb").each { |r| require_relative r }

class Application < Sinatra::Base

  set :logging, :true
  set :cache, Dalli::Client.new(
    ENV['MEMCACHE_SERVERS'], 
    :username => ENV['MEMCACHE_USERNAME'], 
    :password => ENV['MEMCACHE_PASSWORD'], 
    :expires_in => 3600)

  set :config, Proc.new {
    full_yaml_config = YAML.load_file("config/application.yml")
    full_yaml_config[Application.environment.to_s]
  }

  get '/:domain/:resource_type' do | domain, resource_type |
    case domain
    when "news"
      @domain_display_name = "News"
    when "learn"
      @domain_display_name = "Learn"
    else
      throw :halt, [404, "Not found"]
    end

    #index_controller = IndexController.new
    #@events = index_controller.run!
    erb :index
  end

  get '/:domain/:resource_type/:id' do | domain, resource_type, id |
    case domain
    when "news"
      @domain_display_name = "News"
    when "learn"
      @domain_display_name = "Learn"
    else
      throw :halt, [404, "Not found"]
    end

    case resource_type
    when "events"
      events_controller = EventsController.new(id)
      @event = events_controller.run!
      erb :event
    else
      throw :halt, [404, "Not found"]
    end
  end

end
