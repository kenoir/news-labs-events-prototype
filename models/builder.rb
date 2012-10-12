class Builder
  include Loggable

  def build_news_event(event)
    event.relations[:event_people] = EventPeopleRelation.new
    event.relations[:event_places] = EventPlacesRelation.new
    event.relations[:event_articles] = EventArticlesRelation.new

    event.load!
    event.populate!
    event.relations.each do | key, relation |
      next if relation.objects.nil?

      relation.objects.each do | object |
        begin
          object.load!
          object.populate!
        rescue Exception => e
          log("Oops, could not load relation: #{object.inspect}",e)
        end
      end
    end

    event
  end

  def build_news_article(article)
    unloaded_graph = RDF::Graph.new(article.uri)
    article.unloaded_graph = unloaded_graph

    article.load!
    article.populate!

    article
  end

end
