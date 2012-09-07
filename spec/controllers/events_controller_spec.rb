describe EventsController, "#initialize" do
  pending 
end

describe EventsController, "#run" do

  it 'should create a Parser' do
    events_controller = EventsController.new
    events_controller.run!

    events_controller.parser.should be_an_instance_of(Parser)
  end

end

