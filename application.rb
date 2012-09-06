require 'sinatra'
require 'sinatra/base'

class Application < Sinatra::Base

  get '/' do
    @content = "Hello, World!"
    erb :index
  end
  
  get '/event' do
    @title = ""
    @content = "Hello, World!"
    erb :eventportal
  end
  
  get '/article' do
    @content = "Hello, World!"
    erb :article
  end

end
