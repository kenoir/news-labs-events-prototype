require 'events'
require 'rack/test'

set :environment, :test

def app
  Sinatra::Application
end

describe 'Events' do
  include Rack::Test::Methods

  it "should say hi" do
    get '/events'
    last_response.should be_ok
  end

end
