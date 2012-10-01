require_relative 'news_page_controller.rb'
require_relative '../models/relations/event_people_relation.rb'
require_relative '../models/relations/event_places_relation.rb'

class NewsEventsPageController < NewsPageController 
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
    response = @rest_client.get(events_api_uri)
    @json = JSON.parse(response.to_str)

    @json
  end

  def run! 
    load    

    @event = Event.new(events_uri)
    @event.relations[:event_people] = EventPeopleRelation.new
    @event.relations[:event_places] = EventPlacesRelation.new

    @event.load!
    @event.populate!
    @event.relations.each do | key, relation |
      relation.objects.each do | object |
        object.load!
        object.populate!
      end
    end

abort @event.relations[:event_places].objects.first.inspect

    @builder.populate(@event.places) 

    @event.articles =  @builder.build_array_of_type('Article','url',@json['articles'])

    if not @event.people.empty?
      @event.people.each do |person|
    article_json_for_person  = person.related_articles
        articles_for_person = @builder.build_array_of_type('Article','url',article_json_for_person)

        person.articles.concat articles_for_person
      end
    end
    
    page(:event,@event)
  end

  def events_uri
    @event_base_path + @id.to_s
  end

  def events_api_uri
    @event_api_base_path + @id.to_s
  end

end
