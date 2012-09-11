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
    graph.load!
  end

  def content 
    dbp_ont = RDF::Vocabulary.new("http://dbpedia.org/ontology/")
    query = RDF::Query.new({
      :content => {
        dbp_ont.abstract => :abstract,
        dbp_ont.thumbnail=> :thumbnail
      }
    })

    solutions = query.execute(graph)
    solutions.filter { |solution| solution.abstract.language == :en }

    solutions.first.to_hash
  end
end
