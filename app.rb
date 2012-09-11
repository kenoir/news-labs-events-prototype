require 'sinatra'
require 'sinatra/base'
require 'yaml'

Dir.glob("controllers/*.rb").each { |r| require_relative r }
Dir.glob("models/*.rb").each { |r| require_relative r }

class Application < Sinatra::Base

  set :config, Proc.new {
    full_yaml_config = YAML.load_file("config/application.yml")
    full_yaml_config[Application.environment.to_s]
  }

  get '/' do
    erb :index
  end

  get '/event/:id' do |id|
    events_controller = EventsController.new(id,Application.config['event_base_path'])
    @event = events_controller.run!

    erb :event
  end

  get '/article/:id' do |id|

    erb :article
  end

end
