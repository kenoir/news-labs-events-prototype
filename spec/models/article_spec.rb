describe Article, '#populate!' do
  it 'should set the correct content' do
    article = Article.new(rdf_article_resource_uri)
    article.load!
    article.populate!

    article.title.should_not be_nil
    article.description.should_not be_nil
  end
end
