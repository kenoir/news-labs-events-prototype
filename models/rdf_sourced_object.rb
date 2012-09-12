class RDFSourcedObject
  require 'rdf'
  require 'rdf/rdfxml'

  include RDF

  attr :base_uri,true
  attr :uri
  attr :graph

  def initialize(uri)
    @base_uri = Application.config["rdf_base_path"]
    @uri = uri

    @graph = RDF::Graph.new("#{@base_uri}#{@uri}")
  end

  def load!
    @graph.load!
  end

  def populate! 
    raise NotImplementedError.new
  end

end
