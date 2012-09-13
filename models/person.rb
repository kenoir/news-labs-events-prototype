require_relative './rdf_sourced_object'
require_relative './article'

class Person < RDFSourcedObject

  attr :name
  attr :thumbnail
  attr :abstract

  def populate!
    dbp_ont = RDF::Vocabulary.new("http://dbpedia.org/ontology/")
    query = RDF::Query.new({
      :content => {
        RDFS.label => :name,
        dbp_ont.abstract => :abstract,
        dbp_ont.thumbnail => :thumbnail
      }
    })

    solutions = query.execute(@graph)
    solutions.filter { |solution| solution.name.language == :en }
    solutions.filter { |solution| solution.abstract.language == :en }
    solution_hash = solutions.first.to_hash

    @name = solution_hash[:name]
    @abstract = solution_hash[:abstract]
    @thumbnail = solution_hash[:thumbnail]
  end

  def related_articles
    ontology = 'http://data.press.net/ontology/tag/mentions'
    query_uri = "#{@article_query_base_uri}binding=article&limit=5&where=?article%20%3C#{ontology}%3E%20%3C#{@uri}%3E"

    response = RestClient.get query_uri, {:accept => :json}
    parsed_json = JSON.parse(response)
    articles = parsed_json['articles']

    articles
  end

end
