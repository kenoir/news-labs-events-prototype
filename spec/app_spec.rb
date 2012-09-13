describe 'Application' do
  include Rack::Test::Methods

  it "should provide event pages" do
    get '/event/1'
    last_response.should be_ok
  end

end
