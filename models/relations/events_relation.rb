class EventsRelation
  require 'rdf'
  require 'rdf/rdfxml'

  include RDF

  attr :graph, true
  attr :objects

  def populate!
    @objects = Array.new

    tag = RDF::Vocabulary.new("http://data.press.net/ontology/tag/")
    query = RDF::Query.new({
      :events => {
        tag.about => :uri,
      }
    })

    # If we haven't loaded @graph return an empty array
    return @objects if @graph.nil?

    solutions = query.execute(@graph)

    return @objects if solutions.empty?

    solutions.each do | solution |
      event_hash = solution.to_hash   
      @objects.push Event.new(event_hash[:uri].to_s)
    end

    @objects = @objects
  end

end
