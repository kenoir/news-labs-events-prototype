describe EventPeopleArticlesRelation do

  subject { EventPeopleArticlesRelation.new }

  describe EventPeopleArticlesRelation, '#populate!' do
    it 'should return an array of articles' do
      subject.graph = rdf_person_resource_uri 
      articles = subject.populate!

      articles.should_not be_empty
      articles.each do | article |
        article.should be_an_instance_of(Article)
      end
      
      pending
    end
  end

end
