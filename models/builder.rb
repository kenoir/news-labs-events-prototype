class Builder
  include Loggable

  def build_news_event(event)
    event.relations[:event_people] = EventPeopleRelation.new
    event.relations[:event_places] = EventPlacesRelation.new
    event.relations[:event_articles] = EventArticlesRelation.new

    event.load!
    event.populate!
    event.relations.each do | key, relation |
      next if relation.objects.nil?

      relation.objects.each do | object |
        object.load!
        object.populate!
      end
    end

    event
  end

end
