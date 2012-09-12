class Builder
  require 'json'

  attr :json, true 
  attr :rest_client

  def initialize(rest_client)
    @rest_client = rest_client
  end

  def load(uri)
    response = @rest_client.get(uri)
    @json = response.to_str

    @json
  end
  
  def build(json = nil)

    if not json.nil?
      @json = json 
    end

    @parsed_json = JSON.parse(@json)

    event = Event.new(@parsed_json['uri'])
    event = populate(event)

    event.people = build_array_of_type('Person','uri',@parsed_json['agents'])
    event.articles = build_array_of_type('Article','url',@parsed_json['articles'])

    event
  end

  def build_array_of_type(type,key,parsed_json)
    concepts = Array.new
    if not parsed_json.kind_of?(Array) 
      return concepts
    end

    parsed_json.each { | item |
      instantiation_string = "#{type}.new(item['#{key}'])"
      concept = eval(instantiation_string)
      populate(concept)
      concepts.push(concept)
    }

    concepts

  end

  def populate(object)
    object.load!
    object.populate!

    object
  end

end
