describe 'Application' do
  include Rack::Test::Methods

  it "should provide article pages" do
    get '/article/1234'
    last_response.should be_ok
  end

  it "should provide event pages" do
    RestAssured::Server.start(:port =>6666)
    RestAssured::Double.create(
      :fullpath => events_api_endpoint,
      :content => event_json
    )

    get '/event/1234'
    last_response.should be_ok
  end

end
