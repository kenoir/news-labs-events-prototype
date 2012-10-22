class Builder
  include Loggable

  def fix_event_uri(uri)
    uri.sub("http://juicer.responsivenews.co.uk/events/",
            Application.config['events_base_path'])
  end

  def fix_agent_uri(uri)
    dbpedia_id = uri.split('/').last
    
    "#{Application.config['people_base_path']}#{dbpedia_id}"
  end

  def fix_place_uri(uri)
    dbpedia_id = uri.split('/').last
    
    "#{Application.config['places_base_path']}#{dbpedia_id}"
  end

  def fix_article_uri(uri)
    article_id = uri.split('-').last

    "#{Application.config['article_base_path']}#{article_id}"
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

    if not event.relations[:articles].objects.nil?
      event.relations[:articles].objects.take(9).each do | article |
        begin
          article_uri = fix_article_uri(article.uri)

          unloaded_graph = RDF::Graph.new(article_uri)
          article.unloaded_graph = unloaded_graph

          article.load!
          article.populate!
        rescue Exception => e
          log("Could not load relation: #{article.inspect}",e)
        end
      end
    end

    if not event.relations[:places].objects.nil?
      event.relations[:places].objects.each do | place |
        begin
          place.load!
          place.populate!
        rescue Exception => e
          log("Could not load relation: #{place.inspect}",e)
        end
      end
    end

    if not event.relations[:agents].objects.nil?
      event.relations[:agents].objects.take(4).each do | agent |
        begin
          agent.load!
          agent.populate!

          agent.relations[:articles] = ArticlesRelation.new
          agent.relations[:articles].graph = event.graph
          agent.relations[:articles].populate!

          agent.relations[:articles].objects.take(3).each do | object |
            begin
              object.load!
              object.populate!
            rescue Exception => e
              log("Could not load #{object.uri}",e)
            end
          end
        rescue Exception => e
          log("Could not load relation: #{agent.inspect}",e)
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

    if not article.relations[:events].objects.nil?
      article.relations[:events].objects.each do | event |
      uri = fix_event_uri(event.uri)

      unloaded_graph = RDF::Graph.new(uri)
      event.unloaded_graph = unloaded_graph

      event.load!
      event.populate!
      end
    end

    if not article.relations[:places].objects.nil?
      article.relations[:places].objects.take(3).each do | place |
        
        begin
          uri = fix_place_uri(place.uri)

          unloaded_graph = RDF::Graph.new(uri)
          place.unloaded_graph = unloaded_graph

          place.load!
          place.populate!

          place.relations[:learn] = AboutRelation.new
          place.relations[:learn].graph = place.graph
          place.relations[:learn].populate!

          place.relations[:learn].objects.take(3).each do | object |
            begin
              object.load!
              object.populate!
            rescue Exception => e
              log("Could not load #{object.uri}",e)
            end
          end
          
        rescue Exception => e
          log("Could not load #{place.uri}",e)
        end

      end
    end

    if not article.relations[:agents].objects.nil?
      article.relations[:agents].objects.take(3).each do | agent |

        begin
          uri = fix_agent_uri(agent.uri)

          unloaded_graph = RDF::Graph.new(uri)
          agent.unloaded_graph = unloaded_graph

          agent.load!
          agent.populate!

          agent.relations[:learn] = AboutRelation.new
          agent.relations[:learn].graph = agent.graph
          agent.relations[:learn].populate!

          agent.relations[:learn].objects.take(3).each do | object |
            begin
              object.load!
              object.populate!
            rescue Exception => e
              log("Could not load #{object.uri}",e)
            end
          end
          
        rescue Exception => e
          log("Could not load #{agent.uri}",e)
        end

      end

    end

    article
  end

end
