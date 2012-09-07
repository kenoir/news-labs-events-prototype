class EventsController
  require 'rest_client'

  attr :parser, true

  def run! 
    @parser = Parser.new(RestClient)    
  end

end
