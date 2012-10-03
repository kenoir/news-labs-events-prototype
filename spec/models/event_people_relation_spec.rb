describe EventPeopleRelation do

  subject { EventPeopleRelation.new }

  describe EventPeopleRelation, '#populate!' do
    it 'should return an array of people' do
      event = Event.new(rdf_event_resource_uri)
      event.load!
      event.populate!

      subject.graph = event.graph
      people = subject.populate!

      people.should_not be_empty
      people.each do | person |
        person.should be_an_instance_of(Person)
      end
    end
  end

end
