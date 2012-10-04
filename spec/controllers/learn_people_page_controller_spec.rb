describe LearnPeoplePageController do

  subject { LearnPeoplePageController.new(dummy_id) }

  describe LearnPeoplePageController, "#run" do
    it 'should return a hash with the subject key :people' do
      page = subject.run!
      page.should have_key(:people)
    end
  end

end

