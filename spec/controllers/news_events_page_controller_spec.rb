describe NewsEventsPageController, "#initialize" do
  it 'should accept and set an event ID' do
    events_controller = NewsEventsPageController.new(dummy_id)
    events_controller.event_api_base_path = dummy_event_api_base_path

    events_controller.id.should == dummy_id
  end
  
  it 'should accept and set an event_api_base_path' do
    events_controller = NewsEventsPageController.new(dummy_id)
    events_controller.event_api_base_path = dummy_event_api_base_path

    events_controller.event_api_base_path.should == dummy_event_api_base_path 
  end

  it 'should set rest_client as RestClient' do
    events_controller = NewsEventsPageController.new(dummy_id)
    events_controller.event_api_base_path = dummy_event_api_base_path

    events_controller.rest_client.should == RestClient 
  end

  it 'should set builder as an instance of Builder' do
    events_controller = NewsEventsPageController.new(dummy_id)
    events_controller.event_api_base_path = dummy_event_api_base_path

    events_controller.builder.should be_an_instance_of(Builder)
  end

end

describe NewsEventsPageController, "#run" do

  it 'should call populate then build_array_of_type in the set builder' do
    events_controller = NewsEventsPageController.new(dummy_id)
    events_controller.event_api_base_path = dummy_event_api_base_path
    events_controller.event_base_path = dummy_event_base_path
    events_controller.rest_client = dummy_rest_client

    builder = double('Builder')

    builder.should_receive(:populate).exactly(3).times
    builder.should_receive(:build_array_of_type).any_number_of_times

    events_controller.builder = builder
    events_controller.run!
  end

  it 'should return a hash containing :event and set the event' do
    events_controller = NewsEventsPageController.new(dummy_id)
    events_controller.event_api_base_path = dummy_event_api_base_path
    events_controller.event_base_path = dummy_event_base_path
    events_controller.rest_client = dummy_rest_client

    builder = double('Builder') 
    builder.stub(:populate)
    builder.stub(:build_array_of_type)

    events_controller.builder = builder

    page = events_controller.run!
    page[:event].should be_an_instance_of(Event)
  end

end

describe NewsEventsPageController, "#events_uri" do
  it 'should return an events_uri when passed an id' do
    events_controller = NewsEventsPageController.new(dummy_id)
    events_controller.event_base_path = dummy_event_base_path

    events_controller.events_uri.should == dummy_event_base_path + dummy_id.to_s
  end
end
