require_relative './rdf_sourced_object'

class Article < RDFSourcedObject

  attr :title
  attr :description
  attr :id
  attr :image

  def populate!
    dcim = RDF::Vocabulary.new("http://purl.org/dc/dcmitype/")

    query = RDF::Query.new({
      :content => {
        dcim.image => :image,
        DC.title => :title,
        DC.description => :description,
        DC.identifier => :id
      }
    })

    solutions = query.execute(@graph)

    solutions.filter { |solution| solution.title.language == :en }
    solutions.filter { |solution| solution.description.language == :en }

    solution_hash = solutions.first.to_hash

    @title = solution_hash[:title].to_s
    @description = solution_hash[:description].to_s
    @id = solution_hash[:id].to_s
    @image = solution_hash[:image].to_s
  end

end
