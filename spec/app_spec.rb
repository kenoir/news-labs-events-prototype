require 'app'
require 'rack/test'

set :environment, :test

def app
  Sinatra::Application
end

describe 'Juicy Timeline' do
  include Rack::Test::Methods

  it "should say hi" do
    get '/hi'
    last_response.should be_ok
  end

end
