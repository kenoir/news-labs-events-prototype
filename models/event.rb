require_relative './rdf_sourced_object'

class Event < RDFSourcedObject

  attr :name
  attr :description

  def populate!
    query = RDF::Query.new({
      :content => {
        RDFS.label => :name,
      }
    })

    solutions = query.execute(@graph)
    if solutions.count > 0
      solution_hash = solutions.first.to_hash

      @name = solution_hash[:name]
    end
  end

end
