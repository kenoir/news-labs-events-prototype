describe EventsController, "#initialize" do
  it 'should accept and set an event ID' do
    events_controller = EventsController.new(dummy_id,dummy_events_base_path)

    events_controller.id.should == dummy_id
  end
  
  it 'should accept and set an events_base_path' do
    events_controller = EventsController.new(dummy_id,dummy_events_base_path)

    events_controller.events_base_path.should == dummy_events_base_path 
  end

  it 'should set rest_client as RestClient' do
    events_controller = EventsController.new(dummy_id,dummy_events_base_path)

    events_controller.rest_client.should == RestClient 
  end

  it 'should set builder as an instance of Builder' do
    events_controller = EventsController.new(dummy_id,dummy_events_base_path)

    events_controller.builder.should be_an_instance_of(Builder)
  end

end

describe EventsController, "#load" do

  it 'should GET data from a given URI' do
    events_controller = EventsController.new(dummy_id,dummy_events_base_path)
    events_controller.rest_client = dummy_rest_client

    dummy_rest_client.should_receive(:get).with(dummy_url)

    events_controller.load
  end

  it 'should return, parse and set the JSON GET response' do
    events_controller = EventsController.new(dummy_id,dummy_events_base_path)
    events_controller.rest_client = dummy_rest_client

    json = events_controller.load

    events_controller.json.should == parsed_dummy_json
    json.should == parsed_dummy_json
  end

end



describe EventsController, "#run" do

  it 'should call populate then build_array_of_type in the set builder' do
    events_controller = EventsController.new(dummy_id,dummy_events_base_path)
    events_controller.rest_client = dummy_rest_client

    builder = double('Builder')

    builder.should_receive(:populate).ordered
    builder.should_receive(:build_array_of_type).any_number_of_times

    events_controller.builder = builder
    events_controller.run!
  end

  it 'should return and set an event' do
    events_controller = EventsController.new(dummy_id,dummy_events_base_path)
    events_controller.rest_client = dummy_rest_client

    builder = double('Builder') 
    builder.stub(:populate)
    builder.stub(:build_array_of_type)

    events_controller.builder = builder

    actual_event = events_controller.run!
    actual_event.should be_an_instance_of(Event)
  end

end

describe EventsController, "#events_uri" do
  it 'should return an events_uri when passed an id' do
    events_controller = EventsController.new(dummy_id,dummy_events_base_path)

    events_controller.events_uri.should == dummy_events_base_path + dummy_id.to_s
  end
end
