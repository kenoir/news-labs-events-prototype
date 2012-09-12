class RDFSourcedObject
  require 'rdf'
  require 'rdf/rdfxml'

  include RDF

  attr :base_uri,true
  attr :uri
  attr :graph

  attr :thumbnail
  attr :abstract

  def initialize(uri)
    @base_uri = Application.config["rdf_base_path"]
    @uri = uri

    @graph = RDF::Graph.new("#{@base_uri}#{@uri}")
  end

  def load!
    @graph.load!
  end

  def content 
    dbp_ont = RDF::Vocabulary.new("http://dbpedia.org/ontology/")
    query = RDF::Query.new({
      :content => {
        dbp_ont.abstract => :abstract,
        dbp_ont.thumbnail=> :thumbnail
      }
    })

    solutions = query.execute(@graph)
    solutions.filter { |solution| solution.abstract.language == :en }
    solution_hash = solutions.first.to_hash

    # REFACTOR ME SRSLY GUYS
    @abstract = solution_hash[:abstract]
    @thumbnail = solution_hash[:thumbnail]

    solution_hash
  end
end
