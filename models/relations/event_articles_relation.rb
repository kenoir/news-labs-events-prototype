class EventArticlesRelation
  attr :rest_client
  attr :event_api_base_path, true
  attr :graph, true
  attr :json
  attr :objects

  def initialize(rest_client = RestClient)
    @rest_client = rest_client
    @event_api_base_path = Application.config['event_api_base_path'] 
  end

  def populate!
    load
    
    articles = build_array_of_articles(@json['articles'])
    @objects = articles
  end

  private
  def load
    if not ENV['REST_PROXY'].nil?
      #@rest_client.proxy = ENV['REST_PROXY']
    end

    response = @rest_client.get(events_api_uri)
    @json = JSON.parse(response.to_str)

    @json
  end

  private
  def events_api_uri
    id = @graph.to_s.split("\/").last
    @event_api_base_path + id 
  end

  private
  def build_array_of_articles(parsed_json)
    articles = Array.new
    if not parsed_json.kind_of?(Array) 
      return concepts
    end

    parsed_json.each do | item |
      url = "#{Application.config['article_base_path']}#{item["cps_id"]}"

      article = Article.new( url )
      article.unloaded_graph = RDF::Graph.new( url )

      articles.push(article)
    end

    articles
  end

end
