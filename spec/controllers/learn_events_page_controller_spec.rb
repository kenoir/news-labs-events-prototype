describe LearnEventsPageController do

  subject { LearnEventsPageController.new(dummy_id) }

  describe LearnEventsPageController, "#run" do
    it 'should return a hash with the subject key :event' do
      page = subject.run!
      page.should have_key(:event)
    end
  end

end
