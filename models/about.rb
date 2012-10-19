require_relative './rdf_sourced_object'

class About < RDFSourcedObject

  attr :title
  attr :image
  attr :description

  def populate!
    #Required
    query = RDF::Query.new({
      :content => {
        DC.title => :title,
      }
    })

    solutions = query.execute(@graph)
    solution_hash = solutions.first.to_hash

    @title = solution_hash[:title].to_s

    # Optional
    dc_elements = RDF::Vocabulary.new("http://purl.org/dc/elements/1.1/")
    dcim = RDF::Vocabulary.new("http://purl.org/dc/dcmitype/")

    query = RDF::Query.new({
      :content => {
        dcim.Image => :image,
        dc_elements.description => :description
      }
    })

    solutions = query.execute(@graph)
    solution_hash = solutions.first.to_hash

    @description = solution_hash[:description].to_s
    @image = solution_hash[:image].to_s

    @populated = true
  end

end
