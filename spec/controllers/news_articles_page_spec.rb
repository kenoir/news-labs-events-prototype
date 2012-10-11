describe NewsArticlesPageController do

  subject { NewsArticlesPageController.new(dummy_id) }

  describe NewsArticlesPageController, "#run" do
    page = subject.run!
    page.should have_key(:article)
  end

end
