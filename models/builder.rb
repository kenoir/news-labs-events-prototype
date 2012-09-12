class Builder
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
  
  def build(json = nil)

    if not json.nil?
      @json = json 
    end

    @parsed_json = JSON.parse(@json)

    event = Event.new(@parsed_json['uri'])
    event = build_event(event)
    event.people = build_people(@parsed_json['agents'])

    event
  end

  def build_people(parsed_people_json)
    people = Array.new
    if not parsed_people_json.kind_of?(Array) 
      return people
    end

    parsed_people_json.each { | parsed_person_json |
      person = Person.new(parsed_person_json['uri'])
      build_person(person)
      people.push(person)
    }

    people
  end

  def build_event(event)
    event.load!
    event.populate!

    event
  end

  def build_person(person)
      person.load!
      person.populate!

      person
  end
end
