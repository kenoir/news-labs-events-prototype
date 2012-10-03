describe EventPlacesRelation do

  subject { EventPlacesRelation.new }

  describe EventPlacesRelation, '#populate!' do
    it 'should return an array of places' do
      event = Event.new(rdf_event_resource_uri)
      event.load!
      event.populate!

      subject.graph = event.graph
      places = subject.populate!

      places.should_not be_empty
      places.each do | place |
        place.should be_an_instance_of(Place)
      end
    end
  end

end
