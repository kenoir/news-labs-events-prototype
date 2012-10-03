class EventPeopleRelation
  require 'rdf'
  require 'rdf/rdfxml'

  include RDF

  attr :graph, true
  attr :objects

  def populate!
    all_agents = Array.new

    event = RDF::Vocabulary.new("http://purl.org/NET/c4dm/event.owl#")
    query = RDF::Query.new({
      :agents => {
        event.agent => :uri
      }
    })

    # If we haven't loaded @graph return an empty array
    return all_agents if @graph.nil?

    solutions = query.execute(@graph)
    return all_agents if solutions.empty?

    solutions.each do | solution |
      agent_hash = solution.to_hash   
      all_agents.push Person.new(agent_hash[:uri].to_s)
    end

    @objects = all_agents
  end

end
