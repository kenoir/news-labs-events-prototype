require 'sinatra'
require 'sinatra/base'
require 'yaml'

Dir.glob("controllers/*.rb").each { |r| require_relative r }
Dir.glob("mixin/*.rb").each { |r| require_relative r }
Dir.glob("models/*.rb").each { |r| require_relative r }

class Application < Sinatra::Base

  set :config, Proc.new {
    full_yaml_config = YAML.load_file("config/application.yml")
    full_yaml_config[Application.environment.to_s]
  }

  get '/news/events' do
    index_controller = IndexController.new

    @events = index_controller.run!
    erb :index
  end

  get '/news/events/:id' do |id|
    events_controller = EventsController.new(id)

    @event = events_controller.run!
    erb :event
  end

end
