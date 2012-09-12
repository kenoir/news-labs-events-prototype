class RDFSourcedObject
  require 'rdf'
  require 'rdf/rdfxml'

  include RDF

  attr :people, true
  attr :articles, true
  attr :base_uri, true

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

  def related_articles
    #http://juicer.responsivenews.co.uk/api/events?binding=e&where=?e event:agent <http://dbpedia.org/resource/NASA> .&limit=50
    # Make the above call! Note that we are going to need TYPE
  end

end
