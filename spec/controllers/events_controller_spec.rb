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

  it 'should set parser as an instance of Parser' do
    events_controller = EventsController.new(dummy_id,dummy_events_base_path)

    events_controller.parser.should be_an_instance_of(Parser)
  end

end

describe EventsController, "#run" do

  it 'should call load, then parse on the set parser' do
    events_controller = EventsController.new(dummy_id,dummy_events_base_path)
    parser = double('Parser')

    parser.should_receive(:load).ordered
    parser.should_receive(:parse).ordered

    events_controller.parser = parser
    events_controller.run!
  end

  it 'should call load with the correct event URI' do
    events_controller = EventsController.new(dummy_id,dummy_events_base_path)
    parser = double('Parser')

    parser.should_receive(:load).with(events_controller.events_uri)
    parser.should_receive(:parse)

    events_controller.parser = parser
    events_controller.run!
  end

  it 'should return and set an event' do
    events_controller = EventsController.new(dummy_id,dummy_events_base_path)
    parser = double('Parser') 
    event = double('Event')

    parser.should_receive(:load)
    parser.should_receive(:parse).and_return(event)

    events_controller.parser = parser
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
