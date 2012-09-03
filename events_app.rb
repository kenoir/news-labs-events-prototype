require 'sinatra'
require 'sinatra/base'

class Events < Sinatra::Base

  get '/events' do
    @content = "Hello, World!"
    erb :index
  end

end
