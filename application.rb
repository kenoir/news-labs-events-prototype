require 'sinatra'
require 'sinatra/base'

class Application < Sinatra::Base

  get '/' do
    @content = "Hello, World!"
    erb :index
  end
  
  get '/event' do
    @content = "Hello, World!"
    erb :event-portal
  end
  
  get '/article' do
    @content = "Hello, World!"
    erb :article
  end

end
