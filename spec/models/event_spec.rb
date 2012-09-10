describe Event, '#initialize' do

  it 'should accept and set the event URI' do
    event = Event.new(dummy_event_uri)
    event.uri.should == dummy_event_uri 
  end

end
