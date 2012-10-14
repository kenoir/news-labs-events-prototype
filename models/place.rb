require_relative './rdf_sourced_object'

class Place < RDFSourcedObject

  attr :name
  attr :lat
  attr :long

  def populate!
    geo_pos = RDF::Vocabulary.new("http://www.w3.org/2003/01/geo/wgs84_pos#")
    query = RDF::Query.new({
      :content => {
        RDFS.label => :name,
        geo_pos.lat => :lat,
        geo_pos.long => :long
      }
    })

    solutions = query.execute(@graph)
    solutions.filter { |solution| solution.name.language == :en }

    return if solutions.empty?

    solution_hash = solutions.first.to_hash

    @name = solution_hash[:name]
    @lat = solution_hash[:lat]
    @long = solution_hash[:long]

    @populated = true
  end

end
