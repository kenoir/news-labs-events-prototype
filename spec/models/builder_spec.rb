describe Builder, "#build_array_of_type" do
  it 'should return an array of the passed type' do
    builder = Builder.new
    people = builder.build_array_of_type('Person','uri',parsed_event_json['agents'])

    people.each { | person | 
      person.should be_an_instance_of(Person)
    }
  end
end

describe Builder, "#populate" do
  it 'should call load! and then populate! on the passed object' do
    builder = Builder.new
    object = double('Dummy')

    object.should_receive(:load!).ordered
    object.should_receive(:populate!).ordered

    builder.populate(object)
  end
end
