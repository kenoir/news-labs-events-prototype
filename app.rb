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

  get '/news/events/:id' do | id |
    controller = NewsEventsPageController.new(id)
    @page = controller.run!

    erb :news_events
  end

  get '/learn/events/:id' do | id |
    controller = LearnEventsPageController.new(id)
    @page = controller.run!
    erb :learn_events
  end

  get '/learn/places/:id' do | id |
    controller = LearnPlacesPageController.new(id)
    @page = controller.run!
    erb :learn_places
  end

  get '/learn/people/:id' do | id |
    controller = LearnPeoplePageController.new(id)
    @page = controller.run!
    erb :learn_people
  end

end
