class EventsController
  require 'rest_client'
  require 'json'

  attr :event
  attr :json
  attr :id,true
  attr :event_api_base_path,true
  attr :event_base_path,true
  attr :rdf_base_path,true
  attr :rest_client,true
  attr :builder, true

  def initialize(id)
    @id = id
    @rest_client = RestClient
    @builder = Builder.new
    @event_api_base_path = Application.config['event_api_base_path'] 
    @event_base_path = Application.config['event_base_path'] 
    @rdf_base_path = rdf_base_path

    if not ENV['REST_PROXY'].nil?
      @rest_client.proxy = ENV['REST_PROXY']
    end
  end

  def load
    response = @rest_client.get(events_uri)
    @json = JSON.parse(response.to_str)

    @json
  end
 
  def run! 
    #load

puts events_uri 

    @event = Event.new(@json['uri'])

    @builder.populate(@event)

    @event.people = @builder.build_array_of_type('Person','uri',@json['agents'])
    @event.articles =  @builder.build_array_of_type('Article','url',@json['articles'])
    @event.places = @builder.build_array_of_type('Place','uri',@json['places'])

    if not @event.people.nil?
      @event.people.each { |person|
        article_json_for_person  = person.related_articles
        articles_for_person = @builder.build_array_of_type('Article','url',article_json_for_person)

        person.articles = articles_for_person
      }
    end

    @event
  end

  def events_uri
    @event_base_path + @id.to_s
  end

  def events_api_uri
    @event_api_base_path + @id.to_s
  end

end
