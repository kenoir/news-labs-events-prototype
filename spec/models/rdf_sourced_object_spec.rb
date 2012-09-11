describe RDFSourcedObject, '#initialize' do

  it 'should accept and set the event URI' do
    rdf_sourced_object = RDFSourcedObject.new(dummy_event_uri)
    rdf_sourced_object.uri.should == dummy_event_uri 
  end

end

describe RDFSourcedObject, '#load' do
  it 'should load graph from the set uri' do
    rdf_sourced_object = RDFSourcedObject.new(rdf_resource_uri)
    rdf_sourced_object.load!

    rdf_sourced_object.graph.count.should be > 0
  end
end


describe RDFSourcedObject, '#content' do
  it 'should extract dbpedia content' do
    rdf_sourced_object = RDFSourcedObject.new(rdf_resource_uri)
    rdf_sourced_object.load!

    content = rdf_sourced_object.content

    content[:thumbnail].should_not be_nil
    content[:abstract].should_not be_nil
  end
end
