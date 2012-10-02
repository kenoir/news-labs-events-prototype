describe NewsEventsPageController do

  subject { NewsEventsPageController.new( dummy_id ) }

  describe NewsEventsPageController, "#initialize" do
    it 'should accept and set an event ID' do
      subject.id.should == dummy_id
    end

    it 'should set builder as an instance of Builder' do
      controller = NewsEventsPageController.new(dummy_id)
      controller.builder.should be_an_instance_of(Builder)
    end

  end

  describe NewsEventsPageController, "#run" do

    it 'should call populate then build_array_of_type in the set builder' do
      controller = NewsEventsPageController.new(dummy_id)
      controller.event_api_base_path = dummy_event_api_base_path
      controller.event_base_path = dummy_event_base_path
      controller.rest_client = dummy_rest_client

      builder = double('Builder')

      builder.should_receive(:populate).exactly(3).times
      builder.should_receive(:build_array_of_type).any_number_of_times

      controller.builder = builder
      controller.run!
    end

    it 'should return a hash containing :event and set the event' do
      controller = NewsEventsPageController.new(dummy_id)
      controller.event_api_base_path = dummy_event_api_base_path
      controller.event_base_path = dummy_event_base_path
      controller.rest_client = dummy_rest_client

      builder = double('Builder') 
      builder.stub(:populate)
      builder.stub(:build_array_of_type)

      controller.builder = builder

      page = controller.run!
      page[:event].should be_an_instance_of(Event)
    end

  end

  describe NewsEventsPageController, "#events_uri" do
    it 'should return an events_uri when passed an id' do
      controller = NewsEventsPageController.new(dummy_id)
      controller.event_base_path = dummy_event_base_path

      controller.events_uri.should == dummy_event_base_path + dummy_id.to_s
    end
  end

end
