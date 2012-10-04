describe NewsPageController do
  
  subject { NewsPageController.new(dummy_id) }

  describe NewsPageController, '#domain' do
    it 'should return a Hash with :id news,:display_name & :body_class' do
      domain = subject.domain
      domain[:id].should == 'news'
      domain.should have_key(:display_name)
      domain.should have_key(:body_class)
    end
  end

end
