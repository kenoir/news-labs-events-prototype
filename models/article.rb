require_relative './rdf_sourced_object'

class Article < RDFSourcedObject

  attr :title
  attr :description

  def populate!
    query = RDF::Query.new({
      :content => {
        DC.title => :title,
        DC.description => :description
      }
    })

    solutions = query.execute(@graph)
    solutions.filter { |solution| solution.title.language == :en }
    solutions.filter { |solution| solution.description.language == :en }

    solution_hash = solutions.first.to_hash

    @title = solution_hash[:title]
    @description = solution_hash[:description]
  end

end
