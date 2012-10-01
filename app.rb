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

  get '/:domain/:resource_type' do | domain_id, resource_type |
    index_controller = IndexController.new
    @domain = index_controller.domain(domain_id)

    #@events = index_controller.run!
    erb :index
  end

  get '/:domain/:resource_type/:id' do | domain_id, resource_type, id |
    case resource_type
    when "events"
      events_controller = EventsController.new(id)
      @domain = events_controller.domain(domain_id)
      @event = events_controller.run!
      erb :event
    when "places"
      places_controller = PlacesController.new(id)
      @domain = places_controller.domain(domain_id)
      @place = places_controller.run!
      erb :places
    when "people"
      people_controller = PeopleController.new(id)
      @domain = people_controller.domain(domain_id)
      @person = people_controller.run!
      erb :people
    else
      throw :halt, [404, "Not found"]
    end
    
    
  end

end
