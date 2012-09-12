class Parser
  require 'json'

  attr :json, true 
  attr :rest_client

  def initialize(rest_client)
    @rest_client = rest_client
  end

  def load(uri)
    response = @rest_client.get(uri)
    @json = response.to_str

    @json
  end
  
  def parse(json = nil)
    if not json.nil?
      @json = json 
    end

    @parsed_json = JSON.parse(@json)

    event = parse_event(@parsed_json)
    event.people = parse_people(@parsed_json['agents'])

    event
  end

  def parse_event(parsed_event_json)
    event = Event.new(parsed_event_json["uri"])
    event.title = parsed_event_json["title"]
    event.description = parsed_event_json["description"]

    event
  end

  def parse_people(parsed_people_json)
    people = Array.new
    if not parsed_people_json.kind_of?(Array) 
      return people
    end

    parsed_people_json.each { | parsed_person_json |
      person = Person.new(parsed_person_json['uri'])
      person.name = parsed_person_json['label']  

      # REFACTOR ME SRSLY GUYS
      person.load!
      person.content

      people.push(person)
    }

    people
  end

end
