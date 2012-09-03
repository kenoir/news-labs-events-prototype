require 'sinatra'

get '/events' do
  @content = "Hello, World!"
  erb :index
end
