require_relative './rdf_sourced_object'

class Article < RDFSourcedObject

  attr :title
  attr :description
  attr :id
  attr :image
  attr :body

  def populate!

    #Required
    query = RDF::Query.new({
      :content => {
        DC.title => :title,
        DC.identifier => :id,
      }
    })

    solutions = query.execute(@graph)
    solutions.filter { |solution| solution.title.language == :en }
    solution_hash = solutions.first.to_hash

    @title = solution_hash[:title].to_s
    @id = solution_hash[:id].to_s

    @populated = true

    # Optional
    dcim = RDF::Vocabulary.new("http://purl.org/dc/dcmitype/")
    query = RDF::Query.new({
      :content => {
        dcim.image => :image,
        DC.abstract => :abstract,
        DC.description => :body
      }
    })

    solutions = query.execute(@graph)
    solution_hash = solutions.first.to_hash

    @description = solution_hash[:abstract].to_s
    @image = solution_hash[:image].to_s
    @body = solution_hash[:body].to_s

  end

end
