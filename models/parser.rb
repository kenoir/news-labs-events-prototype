class Parser
  require 'json'

  def initialize(rest_client)
    @rest_client = rest_client
  end

  def load(uri)
    response = @rest_client.get(uri)
    response.to_str
  end
  
  def parse(json_data)
    @json_data = JSON.parse(json_data)

    event = Event.new
    event.title = @json_data["title"]

    event
  end

end
