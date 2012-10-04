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

    page(:event,event)
  end

  private
  def events_uri
    Application.config['event_base_path'] + @id.to_s
  end

end
