require './application'
require 'rack/test'

set :environment, :test

def app
  Application
end

describe 'Application' do
  include Rack::Test::Methods

  it "should provide article pages" do
    get '/articles/1234'
    last_response.should be_ok
  end

  it "should provide event pages" do
    get '/events/1234'
    last_response.should be_ok
  end


end
