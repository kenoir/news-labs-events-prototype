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
end

describe RDFSourcedObject, '#populate!' do
  it 'should throw an UnimplementedError' do
    rdf_sourced_object = RDFSourcedObject.new(rdf_person_resource_uri)

    proc {
      rdf_sourced_object.populate!
    }.should raise_error(NotImplementedError)
  end
end

describe RDFSourcedObject, '#related_articles' do
  it 'should return and set an array of Articles' do
    rdf_sourced_object = RDFSourcedObject.new(rdf_person_resource_uri)
    articles = rdf_sourced_object.related_articles

    articles.each { |article|
      article.should be_an_instance_of(Article)
    }
    rdf_sourced_object.articles.should == articles
  end
end
