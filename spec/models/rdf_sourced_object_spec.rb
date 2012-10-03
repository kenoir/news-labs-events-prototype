describe RDFSourcedObject do

  subject { rdf_sourced_object = RDFSourcedObject.new(rdf_event_resource_uri) }

  describe RDFSourcedObject, '#initialize' do
    it 'should accept and set the event URI' do
      subject.uri.should == rdf_event_resource_uri 
    end

    it 'should set relations as a Hash' do
      subject.relations.should be_an_instance_of(Hash)
    end
  end

  describe RDFSourcedObject, '#load!' do
    it 'should load graph from the set uri' do
      subject.load!
      subject.graph.count.should be > 0
    end

    it 'should call graph= and populate! on each set relation' do
      dummy_relation = double('relation')
      dummy_relation.should_receive(:graph=).ordered
      dummy_relation.should_receive(:populate!).ordered

      subject.relations[:dummy_relation] = dummy_relation

      subject.load!
    end

  end

  describe RDFSourcedObject, '#populate!' do
    it 'should throw an UnimplementedError' do
      rdf_sourced_object = RDFSourcedObject.new(rdf_person_resource_uri)

      proc {
        rdf_sourced_object.populate!
      }.should raise_error(NotImplementedError)
    end
  end

end
