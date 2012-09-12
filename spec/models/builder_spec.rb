describe Builder, '#initialize' do
  it 'should accept and set a rest_client' do
    builder = Builder.new(dummy_rest_client)

    builder.rest_client.should == dummy_rest_client
  end
end

describe Builder, "#load" do

  it 'should GET data from a given URI' do
    builder = Builder.new(dummy_rest_client)

    dummy_rest_client.should_receive(:get).with(dummy_url)

    builder.load(dummy_url)
  end

  it 'should return and set the JSON GET response' do
    builder = Builder.new(dummy_rest_client)

    json = builder.load(dummy_url)

    builder.json.should == dummy_json
    json.should == dummy_json
  end

end

describe Builder, "#build_event" do
  it 'should return an event' do
    builder = Builder.new(dummy_rest_client)
    event = builder.build_event(parsed_event_json)

    event.should be_an_instance_of(Event)
  end

end

describe Builder, "#build_people" do
  it 'should return an array of people' do
    builder = Builder.new(dummy_rest_client)
    people = builder.build_people(parsed_event_json['agents'])

    people.each{ | person | 
      person.should be_an_instance_of(Person)
    }
  end

  it 'should return people with the correct values' do
    builder = Builder.new(dummy_rest_client)
    people = builder.build_people(parsed_event_json['agents'])

    parsed_event_json_first_agent = parsed_event_json['agents'].pop

    person = people.pop
    person.name.should == parsed_event_json_first_agent['label'] 
  end

end

describe Builder, "#build" do
  it 'should accept JSON data and return an event' do
    builder = Builder.new(dummy_rest_client)
    event = builder.build(dummy_json)

    event.should be_an_instance_of(Event)
  end

  it 'should use set json if available and return an event' do
    builder = Builder.new(dummy_rest_client)
    builder.json = dummy_json
    event = builder.build

    event.should be_an_instance_of(Event)
  end

  it 'should return an event object with the correct values' do
    builder = Builder.new(dummy_rest_client)

    event = builder.build(event_json)

    event.title.should == parsed_event_json['title'] 
    event.description.should == parsed_event_json['description'] 

  end

  it 'should return an event containing people' do
    builder = Builder.new(dummy_rest_client)
    event = builder.build(event_json)

    event.people.each{ |person|
      person.should be_an_instance_of Person
    }
  end



end

