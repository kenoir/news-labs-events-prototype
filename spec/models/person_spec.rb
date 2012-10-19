describe Person, '#populate!' do
  it 'should set the correct content' do
    person = Person.new(rdf_person_resource_uri)
    person.load!
    person.populate!

    person.name.should_not be_nil
    person.thumbnail.should_not be_nil
    person.abstract.should_not be_nil
  end
end

describe Person, '#related_articles' do
  it 'should return an array' do
    rdf_sourced_object = Person.new(rdf_person_resource_uri)
    articles = rdf_sourced_object.related_articles

    articles.should be_an_instance_of(Array)
    articles.count.should be > 0
  end
end
