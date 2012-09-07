describe Parser, "#load" do
  
  it 'should GET data from a given URI' do
    parser = Parser.new(dummy_rest_client)

    dummy_rest_client.should_receive(:get).with(dummy_url)

    parser.load(dummy_url)
  end

  it 'should return the JSON GET response' do
    parser = Parser.new(dummy_rest_client)

    json = parser.load(dummy_url)
    json.should == dummy_json
  end

end

describe Parser, "#parse" do
  it 'should parse JSON data and return an event' do
    parser = Parser.new(dummy_rest_client)
    event = parser.parse(dummy_json)

    event.should be_an_instance_of(Event)
  end

  it 'should return an event object with the correct values' do
    parser = Parser.new(dummy_rest_client)

    event = parser.parse(event_json)

    event.title.should == "Curiosity Rover lands on Mars"

    pending "Need to check all the values!"
  end

end
