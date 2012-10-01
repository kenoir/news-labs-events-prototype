ENV['RACK_ENV'] = 'test'

require './app'
require 'rack/test'
require 'rest-assured'
require 'json'

require_relative '../models/builder.rb'
require_relative '../models/event.rb'
require_relative '../controllers/events_controller.rb'
require_relative '../controllers/base_controller.rb'
require_relative '../rest-assured/helpers.rb'

include RestAssuredHelpers
start_test_api

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

def dummy_event_base_path 
  'http://juicer.responsivenews.co.uk/events/'
end

def dummy_event_api_base_path
  'http://www.example.com/events/api/'
end

def dummy_event_uri
  'http://www.example.com/id'
end

def dummy_id
  1234
end

def dummy_url
  'http://juicer.responsivenews.co.uk/events/1234'
end

def dummy_json
  parsed_dummy_json.to_json
end

def parsed_dummy_json
  {
    'key' => 'value'
  }
end
