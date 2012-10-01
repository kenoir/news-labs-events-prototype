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

    @articles = []
  end

  def populate! 
    raise NotImplementedError.new
  end

end
