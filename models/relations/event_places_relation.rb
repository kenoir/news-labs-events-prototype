class EventPlacesRelation
  require 'rdf'
  require 'rdf/rdfxml'

  include RDF

  attr :graph, true
  attr :objects

  def populate!
    @objects = Array.new

    event = RDF::Vocabulary.new("http://purl.org/NET/c4dm/event.owl#")
    query = RDF::Query.new({
      :places => {
        event.place => :uri,
      }
    })

    # If we haven't loaded @graph return an empty array
    return @objects if @graph.nil?

    solutions = query.execute(@graph)

    return @objects if solutions.empty?

    solutions.each do | solution |
      place_hash = solution.to_hash   
      @objects.push Place.new(place_hash[:uri].to_s)
    end

    @objects = @objects
  end

end
