class EventArticlesRelation
  attr :rest_client
  attr :event_api_base_path
  attr :graph, true
  attr :json
  attr :objects

  def initialize(rest_client = RestClient)
    @rest_client = rest_client
    @event_api_base_path = Application.config['event_api_base_path'] 
  end

  def populate!
    load
    
    articles = build_array_of_type('Article','url',@json['articles'])
    
    @objects = articles
  end

  private
  def load
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
