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
    event = populate(event)

    event.people = build_people(@parsed_json['agents'])
    event.articles = build_articles(@parsed_json['articles']) 

    event
  end

  def build_array_of_type(type,key,parsed_json)
    concepts = Array.new
    if not parsed_json.kind_of?(Array) 
      return concepts
    end

    parsed_json.each { | item |
      instantiation_string = "#{type}.new(item[key])"
      concept = eval(instantiation_string)
      populate(concept)
      concepts.push(concept)
    }

    concepts

  end

  def build_articles(parsed_articles_json)
    articles = Array.new
    if not parsed_articles_json.kind_of?(Array) 
      return articles
    end

    parsed_articles_json.each { | parsed_article_json |
      article  = Article.new(parsed_article_json['url'])
      populate(article)
      articles.push(article)
    }

    articles
  end

  def build_people(parsed_people_json)
    people = Array.new
    if not parsed_people_json.kind_of?(Array) 
      return people
    end

    parsed_people_json.each { | parsed_person_json |
      person = Person.new(parsed_person_json['uri'])
      populate(person)
      people.push(person)
    }

    people
  end

  def populate(object)
    object.load!
    object.populate!

    object
  end

end
