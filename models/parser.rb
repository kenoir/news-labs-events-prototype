class Parser
  require 'json'

  attr :json, true 
  attr :rest_client

  def initialize(rest_client)
    @rest_client = rest_client
  end

  def load(uri)

puts uri

    response = @rest_client.get(uri)
    @json = response.to_str

    @json
  end
  
  def parse(json = nil)
    if !json.nil?
      @json = json 
    end

    @parsed_json = JSON.parse(@json)

    event = Event.new(@parsed_json["uri"])
    event.title = @parsed_json["title"]
    event.description = @parsed_json["description"]

    event
  end

end
