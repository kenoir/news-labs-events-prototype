require_relative './rdf_sourced_object'

class Person < RDFSourcedObject

  attr :name
  attr :thumbnail
  attr :abstract
  attr :articles

  def populate!
    @articles = []

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

    return if solutions.empty?

    solution_hash = solutions.first.to_hash

    @name = solution_hash[:name].to_s
    @abstract = solution_hash[:abstract].to_s
    @thumbnail = solution_hash[:thumbnail].to_s

    @populated = true

    @articles = related_articles
  end

  def related_articles
    ontology = 'http://data.press.net/ontology/tag/mentions'
    #query_uri = "#{Application.config['article_query_base_uri']}binding=article&limit=5&where=?article%20%3C#{ontology}%3E%20%3C#{@uri}%3E"
    query_uri = "#{Application.config['article_query_json_path']}text=#{@name.sub(" ","+")}&page_length=5&commit=Filter&format=json"

    articles = Array.new

    begin
      parsed_json = cache(query_uri) {
        response = RestClient.get query_uri, {:accept => :json}
        parsed_json = JSON.parse(response)
      }

      if not parsed_json['articles'].nil? and parsed_json['articles'].instance_of? Array
        articles.concat(parsed_json['articles'])
      else 
        raise "Articles not found for person"
      end

    rescue Exception => e
      log("Exception raised trying to populate related articles for person",e)
    end

    articles
  end

end
