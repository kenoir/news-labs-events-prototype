require_relative './rdf_sourced_object'

class Person < RDFSourcedObject

  attr :name
  attr :thumbnail
  attr :abstract

  def populate!
    dbp_ont = RDF::Vocabulary.new("http://dbpedia.org/ontology/")
    query = RDF::Query.new({
      :content => {
        RDFS.label => :name,
        dbp_ont.abstract => :abstract,
        dbp_ont.thumbnail => :thumbnail
      }
    })

    solutions = query.execute(@graph)
    solutions.filter { |solution| solution.name.language == :en }
    solutions.filter { |solution| solution.abstract.language == :en }
    solution_hash = solutions.first.to_hash

    @name = solution_hash[:name]
    @abstract = solution_hash[:abstract]
    @thumbnail = solution_hash[:thumbnail]
  end

end
