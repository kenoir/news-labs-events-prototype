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

describe EventsController, "#run" do

  it 'should call load, then build on the set builder' do
    events_controller = EventsController.new(dummy_id,dummy_events_base_path)
    builder = double('Builder')

    builder.should_receive(:load).ordered
    builder.should_receive(:build).ordered

    events_controller.builder = builder
    events_controller.run!
  end

  it 'should call load with the correct event URI' do
    events_controller = EventsController.new(dummy_id,dummy_events_base_path)
    builder = double('Builder')

    builder.should_receive(:load).with(events_controller.events_uri)
    builder.should_receive(:build)

    events_controller.builder = builder
    events_controller.run!
  end

  it 'should return and set an event' do
    events_controller = EventsController.new(dummy_id,dummy_events_base_path)
    builder = double('Builder') 
    event = double('Event')

    builder.should_receive(:load)
    builder.should_receive(:build).and_return(event)

    events_controller.builder = builder
    actual_event = events_controller.run!

    actual_event.should == event
    events_controller.event.should == event
  end

end

describe EventsController, "#events_uri" do
  it 'should return an events_uri when passed an id' do
    events_controller = EventsController.new(dummy_id,dummy_events_base_path)

    events_controller.events_uri.should == dummy_events_base_path + dummy_id.to_s
  end
end
