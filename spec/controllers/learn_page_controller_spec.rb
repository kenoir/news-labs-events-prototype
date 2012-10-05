describe LearnPageController do
  
  subject { LearnPageController.new(dummy_id) }

  describe LearnPageController, '#domain' do
    it 'should return a Hash with :id learn,:display_name & :body_class' do
      domain = subject.domain
      domain[:id].should == 'learn'
      domain.should have_key(:display_name)
      domain.should have_key(:body_class)
    end
  end

end
