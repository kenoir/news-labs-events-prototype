class RDFSourcedObject
  require 'rdf'
  require 'rdf/rdfxml'
  require 'rest-client'
  require 'json'

  include RDF
  include Loggable
  include Cacheable

  attr :relations, true

  attr :articles, true
  attr :people, true
  attr :places, true

  attr :rdf_base_uri
  attr :article_query_base_uri

  attr :uri
  attr :graph
  attr :unloaded_graph

  def initialize(uri)
    @rdf_base_uri = Application.config["rdf_base_path"]
    @article_query_base_uri = Application.config["article_query_base_uri"] 

    @uri = uri

    @unloaded_graph = RDF::Graph.new("#{@rdf_base_uri}#{@uri}")

    @relations = Hash.new

    @articles = []
    @people = []
    @places = []
  end

  def load!
    @graph = cache(@uri) { 
      @unloaded_graph.load!
      @unloaded_graph.clone
    }

    @relations.each do | key,relation |
      relation.graph = @graph
      relation.populate!
    end

    @places = populate_places
    @articles = []
  end

  def populate! 
    raise NotImplementedError.new
  end

  def populate_places
    all_places = Array.new

    event = RDF::Vocabulary.new("http://purl.org/NET/c4dm/event.owl#")
    query = RDF::Query.new({
      :places => {
        event.place => :uri,
      }
    })

    # If we haven't loaded @graph return an empty array
    return all_places if @graph.nil?

    solutions = query.execute(@graph)

    return all_places if solutions.empty?

    solutions.each do | solution |
      place_hash = solution.to_hash   
      all_places.push Place.new(place_hash[:uri].to_s)
    end

    all_places
  end

end
