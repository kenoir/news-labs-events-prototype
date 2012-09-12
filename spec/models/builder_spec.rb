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

describe Builder, "#build_array_of_type" do
  it 'should return an array of the passed type' do
    builder = Builder.new(dummy_rest_client)
    people = builder.build_array_of_type('Person','uri',parsed_event_json['agents'])

    people.each { | person | 
      person.should be_an_instance_of(Person)
    }
  end
end

describe Builder, "#populate" do
  it 'should call load! and then populate! on the passed object' do
    builder = Builder.new(dummy_rest_client)
    object = double('Dummy')

    object.should_receive(:load!).ordered
    object.should_receive(:populate!).ordered

    builder.populate(object)
  end

end

describe Builder, "#build" do

  it 'should accept JSON data and return an event' do
    builder = Builder.new(dummy_rest_client)
    event = builder.build(event_json)

    event.should be_an_instance_of(Event)
  end

  it 'should use set json if available and return an event' do
    builder = Builder.new(dummy_rest_client)
    builder.json = event_json 
    event = builder.build

    event.should be_an_instance_of(Event)
  end

  it 'should return an event object with the correct values' do
    builder = Builder.new(dummy_rest_client)

    event = builder.build(event_json)

    event.name.should == parsed_event_json['title'] 
  end

  it 'should return an event containing people' do
    builder = Builder.new(dummy_rest_client)
    event = builder.build(event_json)

    event.people.each{ |person|
      person.should be_an_instance_of Person
    }
  end

  it 'should return an event containing articles' do
    builder = Builder.new(dummy_rest_client)
    event = builder.build(event_json)

    event.articles.each{ |article|
      article.should be_an_instance_of Article
    }
  end

end

