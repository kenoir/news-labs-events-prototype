class EventsController
  require 'rest_client'
  require 'json'

  attr :event
  attr :json
  attr :id,true
  attr :events_base_path,true
  attr :rdf_base_path,true
  attr :rest_client,true
  attr :builder, true

  def initialize(id)
    @id = id
    @rest_client = RestClient
    @builder = Builder.new
    @events_base_path = Application.config['event_base_path'] 
    @rdf_base_path = rdf_base_path
  end

  def load
    response = @rest_client.get(events_uri)
    @json = JSON.parse(response.to_str)

    @json
  end
 
  def run! 
    load
    @event = Event.new(@json['uri'])

    @builder.populate(event)

    @event.people = @builder.build_array_of_type('Person','uri',@json['agents'])
    @event.articles =  @builder.build_array_of_type('Article','url',@json['articles'])

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
    @events_base_path + @id.to_s
  end

end
