class EventPeopleArticlesRelation
  require 'rdf'
  require 'rdf/rdfxml'

  include RDF
  include Cacheable

  attr :graph, true
  attr :objects

  def populate!
    ontology = 'http://data.press.net/ontology/tag/mentions'
    article_query_base_uri = Application.config['article_query_base_uri']
    binding = "article&limit=5&where=?article%20%3C#{ontology}%3E%20%3C#{@uri}%3E"

    query_uri = "#{article_query_base_uri}binding=#{binding}"
    articles = cache(query_uri) {
      response = RestClient.get query_uri, {:accept => :json}
      parsed_json = JSON.parse(response)
    }

    articles_for_person = build_array_of_type('Article','url',articles)
  end

  private
  def build_array_of_type(type,key,parsed_json)
    concepts = Array.new
    if not parsed_json.kind_of?(Array) 
      return concepts
    end

    parsed_json.each do | item |
      instantiation_string = "#{type}.new(item['#{key}'])"
    concept = eval(instantiation_string)
    concepts.push(concept)
    end

    concepts
  end


end
