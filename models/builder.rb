class Builder
  include Loggable

  def build_news_event(event)
    uri = event.uri.sub("http://juicer.responsivenews.co.uk/events/",
                        "http://bbc-blender.herokuapp.com/events/")

    unloaded_graph = RDF::Graph.new(uri)
    event.unloaded_graph = unloaded_graph

    event.relations[:agents] = AgentRelation.new
    event.relations[:places] = PlacesRelation.new
    event.relations[:articles] = ArticlesRelation.new

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

    # Special case loading data from juicer 
    if not event.relations[:agents].objects.nil?
      event.relations[:agents].objects.each do | agent |
        begin
          agent.load_related_articles_from_juicer
        rescue Exception => e
          log("Could not load related articles from juicer",e)
        end
      end
    end

    event
  end

  def build_news_article(article)
    unloaded_graph = RDF::Graph.new(article.uri)
    article.unloaded_graph = unloaded_graph

    article.relations[:agents] = AgentRelation.new
    article.relations[:places] = PlacesRelation.new
    article.relations[:events] = EventsRelation.new

    article.load!
    article.populate!
    article.relations.each do | key,relation |
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

    article
  end

end
