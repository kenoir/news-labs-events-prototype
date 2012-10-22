require_relative './rdf_sourced_object'

class Person < RDFSourcedObject

  attr :id
  attr :name
  attr :thumbnail
  attr :abstract
  attr :articles

  def populate!
    @articles = []

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

    return if solutions.empty?

    solution_hash = solutions.first.to_hash

    @id = @uri.split('/').last
    @name = solution_hash[:name].to_s
    @abstract = solution_hash[:abstract].to_s
    @thumbnail = solution_hash[:thumbnail].to_s

    @populated = true
  end

end
