require 'sinatra'

set :public_folder, 'public'

get '/events' do
  @content = "Hello, World!"
  erb :index
end
