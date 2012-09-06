require 'sinatra'
require 'sinatra/base'

class Application < Sinatra::Base

  get '/' do
    @content = "Hello, World!"
    erb :index
  end
  
  get '/events/:id' do |id|
    @title = ""
    @content = "Hello, #{id}!"
    erb :event
  end
  
  get '/articles/:id' do |id|
    @content = "Hello #{id}!"
    erb :article
  end

end
