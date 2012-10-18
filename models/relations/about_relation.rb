class AboutRelation
  require 'rdf'
  require 'rdf/rdfxml'

  include RDF
  include Loggable

  attr :graph, true
  attr :objects

  def populate!

    @objects = Array.new
    learn = RDF::Vocabulary.new("http://www.bbc.co.uk/ontologies/learn/")
    query = RDF::Query.new({
      :resource => {
        :place => learn.resource,
        RDF.about => :uri,
      }
    })

    # If we haven't loaded @graph return an empty array
    return @objects if @graph.nil?

    solutions = query.execute(@graph)

    return @objects if solutions.empty?

    solutions.each do | solution |
      article_hash = solution.to_hash   
      article = About.new(article_hash[:resource].to_s)

      @objects.push article 
    end

    @objects
  end

end
