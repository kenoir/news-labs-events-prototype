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

