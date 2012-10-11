describe 'Application' do
  include Rack::Test::Methods

  it "should provide news event pages" do
    get '/news/events/1'
    last_response.should be_ok
  end

  it "should provide k&l event pages" do
    get '/learn/events/1'
    last_response.should be_ok
  end

  it "should provide news article pages" do
    get '/news/articles/1'
    last_response.should be_ok
  end

end
