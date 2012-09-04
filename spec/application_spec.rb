require 'Application'
require 'rack/test'

set :environment, :test

def app
  Application
end

describe 'Application' do
  include Rack::Test::Methods

  it "should say hi" do
    get '/events'
    last_response.should be_ok
  end

end
