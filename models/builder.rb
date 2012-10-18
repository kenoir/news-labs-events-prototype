class Builder
  include Loggable

  def fix_event_uri(uri)
    uri.sub("http://juicer.responsivenews.co.uk/events/",
            "http://bbc-blender.herokuapp.com/events/")
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

    #article.relations.each do | key,relation |
    #  next if relation.objects.nil?

    #  relation.objects.each do | object |
    #    begin
    #      object.load!
    #      object.populate!
    #    rescue Exception => e
    #      log("Oops, could not load relation: #{object.inspect}",e)
    #    end
    #  end
    #end
    
    if not article.relations[:places].objects.nil?
      article.relations[:places].objects.each do | place |
        begin
          place.load!
          place.populate!
        rescue Exception => e
          log("Could not load #{place.uri}",e)
        end
      end
    end

    if not article.relations[:agents].objects.nil?
      article.relations[:agents].objects.each do | agent |
        begin
          agent.load!
          agent.populate!
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
