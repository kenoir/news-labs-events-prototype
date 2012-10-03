describe EventPeopleArticlesRelation do

  subject { EventPeopleArticlesRelation.new }

  describe EventPeopleArticlesRelation, '#populate!' do
    it 'should return an array of articles' do
      event = Event.new(rdf_event_resource_uri)
      event.load!
      event.populate!

      subject.graph = event.graph
      articles = subject.populate!

      articles.should_not be_empty
      articles.each do | article |
        article.should be_an_instance_of(Article)
      end
    end
  end

end
