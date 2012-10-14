class ArticlesRelation
  require 'rdf'
  require 'rdf/rdfxml'

  include RDF

  attr :graph, true
  attr :objects

  def populate!
    @objects = Array.new

    terms = RDF::Vocabulary.new("http://purl.org/dc/terms/")
    query = RDF::Query.new({
      :articles => {
        terms.isReferencedBy => :uri,
      }
    })

    # If we haven't loaded @graph return an empty array
    return @objects if @graph.nil?

    solutions = query.execute(@graph)

    return @objects if solutions.empty?

    solutions.each do | solution |
      article_hash = solution.to_hash   
      @objects.push  Article.new(article_hash[:uri].to_s)
    end

    @objects
  end

end
