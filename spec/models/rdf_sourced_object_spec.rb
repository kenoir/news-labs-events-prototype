describe RDFSourcedObject, '#initialize' do

  it 'should accept and set the event URI' do
    rdf_sourced_object = RDFSourcedObject.new(dummy_event_uri)
    rdf_sourced_object.uri.should == dummy_event_uri 
  end

end

describe RDFSourcedObject, '#load!' do
  it 'should load graph from the set uri' do
    rdf_sourced_object = RDFSourcedObject.new(rdf_person_resource_uri)
    rdf_sourced_object.load!

    rdf_sourced_object.graph.count.should be > 0
  end

  it 'should call and set agents and places' do
    rdf_sourced_object = RDFSourcedObject.new(rdf_event_resource_uri)
    agents = double('agents')
    places = double('places')

    rdf_sourced_object.should_receive(:agents) { agents }
    rdf_sourced_object.should_receive(:places) { places }
    
    rdf_sourced_object.agents.should == agents
    rdf_sourced_object.places.should == places
  end
end

describe RDFSourcedObject, '#places' do
  it 'should return an array of places' do
    rdf_sourced_object = RDFSourcedObject.new(rdf_event_resource_uri)
    rdf_sourced_object.load!

    actual_places = rdf_sourced_object.places

    actual_places.count.should > 0
    actual_places.each do | place |
      place.should be_an_instance_of Place
      puts place.inspect
    end
  end
end

describe RDFSourcedObject, '#agents' do
  it 'should return an array of people' do
    rdf_sourced_object = RDFSourcedObject.new(rdf_event_resource_uri)
    rdf_sourced_object.load!

    actual_agents = rdf_sourced_object.agents
    actual_agents.count.should > 0
    actual_agents.each do | agent |
      agent.should be_an_instance_of Person
    end
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


