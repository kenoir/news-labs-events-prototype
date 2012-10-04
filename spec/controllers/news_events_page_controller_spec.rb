describe NewsEventsPageController do

  subject { NewsEventsPageController.new( dummy_id ) }

  describe NewsEventsPageController, "#run" do
    it 'should call build_news_event in the set builder' do
      builder = double('Builder')
      builder.should_receive(:build_news_event).exactly(1).times

      subject.builder = builder
      subject.run!
    end

    it 'should return a hash containing :event' do
      builder = double('Builder') 
      builder.stub(:build_news_event)

      subject.builder = builder

      page = subject.run!
      page[:event].should be_an_instance_of(Event)
    end
  end

end
