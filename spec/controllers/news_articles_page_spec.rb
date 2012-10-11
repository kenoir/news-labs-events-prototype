describe NewsArticlesPageController do

  subject { NewsArticlesPageController.new(dummy_id) }

  describe NewsArticlesPageController, "#run" do
    it 'should return a hash with the subject key :article' do
      page = subject.run!
      page.should have_key(:article)
    end
  end

end
