require_relative './rdf_sourced_object'

class Event < RDFSourcedObject

  attr :id
  attr :name
  attr :description

  def populate!
    query = RDF::Query.new({
      :content => {
        RDFS.label => :name,
        DC.abstract => :description
      }
    })

    solutions = query.execute(@graph)
    if solutions.count > 0
      solution_hash = solutions.first.to_hash

      @name = solution_hash[:name]
      @description = solution_hash[:description]
    end

    @id = uri.split("/").last
   end
    
end
