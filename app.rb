require 'sinatra'
require 'rest_client'

get '/hi' do
  RestClient.proxy = ENV['http_proxy']
  response = RestClient.get "http://juicer.responsivenews.co.uk/api/events/7"

  response.inspect
end
