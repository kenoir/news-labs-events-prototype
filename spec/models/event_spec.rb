describe Event, '#populate!' do
  it 'should set the correct content' do
    event = Event.new(rdf_event_resource_uri)
    event.load!
    event.populate!
    
    event.name.should_not be_nil
  end
end
