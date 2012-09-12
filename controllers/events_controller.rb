class EventsController
  require 'rest_client'

  attr :event
  attr :id,true
  attr :events_base_path,true
  attr :rdf_base_path,true
  attr :rest_client,true
  attr :builder, true

  def initialize(id,events_base_path)
    @id = id
    @rest_client = RestClient
    @builder = Builder.new(@rest_client)    
    @events_base_path = events_base_path
    @rdf_base_path = rdf_base_path
  end

  def run! 
    @builder.load(events_uri)
    @event = @builder.build

    @event
  end

  def events_uri
    @events_base_path + @id.to_s
  end

end
