describe Builder do

  subject { Builder.new }

  describe Builder, "#build_news_event" do

    it 'should return an event with :people, :places & :articles relations' do
      dummy_relations = Hash.new
      dummy_event = double('event')
      dummy_event.stub(:load!)
      dummy_event.stub(:populate!)
      dummy_event.stub(:relations).and_return(dummy_relations)

      subject.build_news_event(dummy_event)

      dummy_event.relations[:people].should be_an_instance_of(PeopleRelation)
      dummy_event.relations[:places].should be_an_instance_of(PlacesRelation)
      dummy_event.relations[:articles].should be_an_instance_of(ArticlesRelation)
    end
    
    it 'should call load! and populate! on each object for each relation' do
      dummy_relations = Hash.new
      dummy_event = double('event')
      dummy_event.stub(:load!)
      dummy_event.stub(:populate!)
      dummy_event.stub(:relations).and_return(dummy_relations)

      dummy_object = double('object')
      dummy_object.should_receive(:load!).exactly(3).times
      dummy_object.should_receive(:populate!).exactly(3).times

      dummy_relation = double('relation')
      dummy_relation.stub(:objects).and_return([dummy_object])

      PeopleRelation.stub(:new) { dummy_relation }
      PlacesRelation.stub(:new) { dummy_relation }
      ArticlesRelation.stub(:new) { dummy_relation }

      subject.build_news_event(dummy_event)
    end

  end

end
