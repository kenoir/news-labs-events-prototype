class RDFSourcedObject
  require 'rdf'
  require 'rdf/rdfxml'
  require 'rest-client'
  require 'json'

  include RDF

  attr :people, true
  attr :places, true
  attr :articles, true

  attr :rdf_base_uri
  attr :article_query_base_uri

  attr :uri
  attr :graph

  def initialize(uri)
    @rdf_base_uri = Application.config["rdf_base_path"]
    @article_query_base_uri = Application.config["article_query_base_uri"] 

    @uri = uri

    @graph = RDF::Graph.new("#{@rdf_base_uri}#{@uri}")
  end

  def load!
    @graph.load!
  end

  def populate! 
    raise NotImplementedError.new
  end

end
