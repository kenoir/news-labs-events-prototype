describe Place, '#populate' do
  it 'should set the correct content' do
    place = Place.new(rdf_place_resource_uri)
    place.load!
    place.populate!

    place.name.should_not be_nil
    place.lat.should_not be_nil
    place.long.should_not be_nil
  end
end
