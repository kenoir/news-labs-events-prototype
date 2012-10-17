class Builder
  include Loggable

  def fix_event_uri(uri)
    uri.sub("http://juicer.responsivenews.co.uk/events/",
            "http://bbc-blender.herokuapp.com/events/")
  end

  def fix_agent_uri(uri)
    dbpedia_id = uri.split('/').last
    
    "http://bbc-blender.herokuapp.com/people/#{dbpedia_id}"
  end

  def fix_place_uri(uri)
    dbpedia_id = uri.split('/').last
    
    "http://bbc-blender.herokuapp.com/places/#{dbpedia_id}"
  end

  def build_news_event(event)
    uri = fix_event_uri(event.uri) 

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
   
    if not article.relations[:places].objects.nil?
      article.relations[:places].objects.each do | place |
        begin
          uri = fix_place_uri(place.uri)

          unloaded_graph = RDF::Graph.new(uri)
          place.unloaded_graph = unloaded_graph

          place.load!
          place.populate!

          place.relations[:places] = PlacesRelation.new
          place.relations[:places].graph = place.graph
          place.relations[:places].populate!

          place.relations[:places].objects.each do | object |
            begin
            object.load!
            object.populate!
            rescue

            end
          end
        rescue Exception => e
          log("Could not load #{place.uri}",e)
        end
      end
    end

    if not article.relations[:agents].objects.nil?
      article.relations[:agents].objects.each do | agent |
        begin
          uri = fix_agent_uri(agent.uri)
          
          unloaded_graph = RDF::Graph.new(uri)
          agent.unloaded_graph = unloaded_graph

          agent.load!
          agent.populate!

          agent.relations[:agents] = AgentRelation.new
          agent.relations[:agents].graph = agent.graph          
          agent.relations[:agents].populate!

          agent.relations[:agents].objects.each do | object |
            begin
            object.load!
            object.populate!
            rescue

            end
          end
        rescue Exception => e
          log("Could not load #{agent.uri}",e)
        end
      end
    end

    if not article.relations[:events].objects.nil?
      article.relations[:events].objects.each do | event |
        begin
          uri = fix_event_uri(event.uri) 

          unloaded_graph = RDF::Graph.new(uri)
          event.unloaded_graph = unloaded_graph

          event.load!
          event.populate!

          event.relations[:articles] = ArticlesRelation.new
          event.relations[:articles].graph = event.graph          
          event.relations[:articles].populate!

          event.relations[:articles].objects.each do | object |
            begin
            object.load!
            object.populate!
            rescue

            end
          end
        rescue Exception => e
          log("Could not load #{event.uri}",e)
        end
      end
    end

    article
  end

end
