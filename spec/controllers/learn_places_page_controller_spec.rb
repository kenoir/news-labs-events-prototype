describe LearnPlacesPageController do

  subject { LearnPlacesPageController.new(dummy_id) }

  describe LearnPlacesPageController, "#run" do
    it 'should return a hash with the subject key :places' do
      page = subject.run!
      page.should have_key(:places)
    end
  end

end
