describe do

  subject { Event.new(rdf_event_resource_uri) }

  describe Event, '#populate!' do
    it 'should set the correct content' do
      subject.load!
      subject.populate!

      subject.name.should_not be_nil
      subject.description.should_not be_nil
    end
  end

end
