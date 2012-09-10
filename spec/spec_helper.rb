ENV['RACK_ENV'] = 'test'

require './app'
require 'rack/test'
require 'rest-assured'
require 'json'

require_relative '../models/parser.rb'
require_relative '../models/event.rb'
require_relative '../controllers/events_controller.rb'

def app
  Application 
end

def dummy_rest_client
  if defined? @dummy_rest_client 
    return @dummy_rest_client 
  end

  dummy_response = double('Response')
  dummy_response.stub(:to_str).and_return(dummy_json)

  dummy_rest_client = double('RestClient') 
  dummy_rest_client.stub(:get).and_return(dummy_response)

  @dummy_rest_client = dummy_rest_client
end

def dummy_events_base_path
  'http://www.example.com/events/'
end

def dummy_event_uri
  'http://www.example.com/id'
end

def dummy_id
  1234
end

def dummy_url
  'http://www.example.com'
end

def dummy_json
  {
    'key' => 'value'
  }.to_json
end

def read_from_file(location)
  file = File.open(location, "rb")
  contents = file.read
end

def event_json_location
  File.dirname(__FILE__) + '/data/events.json'
end

def events_api_endpoint
  '/event/1234'
end

def event_json
  read_from_file(event_json_location)
end
