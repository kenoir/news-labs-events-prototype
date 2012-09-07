require_relative '../models/parser.rb'
require_relative '../models/event.rb'
require_relative '../controllers/events_controller.rb'

require 'json'

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

def event_json
  read_from_file(event_json_location)
end
