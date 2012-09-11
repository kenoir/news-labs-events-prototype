describe Parser, '#initialize' do
  it 'should accept and set a rest_client' do
    parser = Parser.new(dummy_rest_client)

    parser.rest_client.should == dummy_rest_client
  end
end

describe Parser, "#load" do

  it 'should GET data from a given URI' do
    parser = Parser.new(dummy_rest_client)

    dummy_rest_client.should_receive(:get).with(dummy_url)

    parser.load(dummy_url)
  end

  it 'should return and set the JSON GET response' do
    parser = Parser.new(dummy_rest_client)

    json = parser.load(dummy_url)

    parser.json.should == dummy_json
    json.should == dummy_json
  end

end

describe Parser, "#parse_event" do
  it 'should return an event' do
    parser = Parser.new(dummy_rest_client)
    event = parser.parse_event(parsed_event_json)

    event.should be_an_instance_of(Event)
  end

end

describe Parser, "#parse_people" do
  it 'should return an array of people' do
    parser = Parser.new(dummy_rest_client)
    people = parser.parse_people(parsed_event_json['agents'])

    people.each{ | person | 
      person.should be_an_instance_of(Person)
    }
  end

  it 'should return people with the correct values' do
    parser = Parser.new(dummy_rest_client)
    people = parser.parse_people(parsed_event_json['agents'])

    person = people.pop
    person.name.should == "NASA"
  end

end

describe Parser, "#parse" do
  it 'should accept JSON data and return an event' do
    parser = Parser.new(dummy_rest_client)
    event = parser.parse(dummy_json)

    event.should be_an_instance_of(Event)
  end

  it 'should use set json if available and return an event' do
    parser = Parser.new(dummy_rest_client)
    parser.json = dummy_json
    event = parser.parse

    event.should be_an_instance_of(Event)
  end

  it 'should return an event object with the correct values' do
    parser = Parser.new(dummy_rest_client)

    event = parser.parse(event_json)

    event.title.should == "Curiosity Rover lands on Mars"
    event.description.should == "Curiosity Rover makes perfect landing on Mars, August 6th 2012"

  end

  it 'should return an event containing people' do
    parser = Parser.new(dummy_rest_client)
    event = parser.parse(event_json)

    event.people.each{ |person|
      person.should be_an_instance_of Person
    }
  end



end

