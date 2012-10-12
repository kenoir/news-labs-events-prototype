require_relative 'news_page_controller.rb'
require_relative '../models/relations/event_people_relation.rb'
require_relative '../models/relations/event_places_relation.rb'
require_relative '../models/relations/event_articles_relation.rb'

class NewsEventsPageController < NewsPageController 
  require 'rest_client'
  require 'json'

  attr :event_base_path,true

  def run! 

    event = Event.new(events_uri)
    @builder.build_news_event(event)

=begin
    if not @event.people.empty?
      @event.people.each do |person|
    article_json_for_person  = person.related_articles
        articles_for_person = @builder.build_array_of_type('Article','url',article_json_for_person)

        person.articles.concat articles_for_person
      end
    end
=end
	puts :event
    page(:event,event)
  end

  private
  def events_uri
    Application.config['event_base_path'] + @id.to_s
  end

end
