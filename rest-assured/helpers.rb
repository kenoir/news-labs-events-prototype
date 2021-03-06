module RestAssuredHelpers
  require 'json'

  def read_from_file(location)
    file = File.open(location, "rb")
    contents = file.read
  end

  def event_json_location
    File.join(File.dirname(__FILE__), '/data/event.json')
  end

  def events_api_endpoint
    '/api/events/1'
  end

  def event_json
    read_from_file(event_json_location)
  end

  def parsed_event_json
    JSON.parse(event_json)
  end

  def parsed_article_json
    JSON.parse(articles_person_query_json)
  end

  def rdf_place_resource_uri
    'http://dbpedia.org/resource/place_resource_name'
  end

  def rdf_event_resource_uri
    'http://juicer.responsivenews.co.uk/events/1'
  end

  def rdf_person_resource_uri
    'http://dbpedia.org/resource/person_resource_name'
  end

  def rdf_article_resource_uri
    'http://www.bbc.co.uk/news/article-1234'
  end

  def rdf_place_api_endpoint
    "/rdf?identifier=#{rdf_place_resource_uri}"
  end

  def rdf_person_api_endpoint
    "/rdf?identifier=#{rdf_person_resource_uri}"
  end

  def rdf_event_api_endpoint
    "/rdf?identifier=#{rdf_event_resource_uri}"
  end

  def rdf_article_api_endpoint
    "/rdf?identifier=#{rdf_article_resource_uri}"
  end

  def articles_person_query_endpoint
    "/api/articles?binding=article&limit=5&where=?article%20%3Chttp://data.press.net/ontology/tag/mentions%3E%20%3C#{rdf_person_resource_uri}%3E"
  end

  def articles_person_query_json_location
    File.join(File.dirname(__FILE__), '/data/article_person_query.json')
  end

  def articles_person_query_json
    read_from_file(articles_person_query_json_location)
  end

  def article_resource_xml_location
    File.join(File.dirname(__FILE__), '/data/article_resource.xml')
  end

  def article_resource_xml
    read_from_file(article_resource_xml_location)
  end

  def place_resource_xml_location
    File.join(File.dirname(__FILE__), '/data/place_resource.xml')
  end

  def person_resource_xml_location
    File.join(File.dirname(__FILE__), '/data/person_resource.xml')
  end

  def event_resource_xml_location
    File.join(File.dirname(__FILE__), '/data/event_resource.xml')
  end

  def place_resource_xml
    read_from_file(place_resource_xml_location)
  end

  def person_resource_xml
    read_from_file(person_resource_xml_location)
  end

  def event_resource_xml
    read_from_file(event_resource_xml_location)
  end

  def start_test_api
    RestAssured::Server.start(:port =>6666)
    RestAssured::Double.create(
      :fullpath => events_api_endpoint,
      :content => event_json
    )
    RestAssured::Double.create(
      :fullpath => rdf_person_api_endpoint,
      :content => person_resource_xml 
    )
    RestAssured::Double.create(
      :fullpath => rdf_event_api_endpoint,
      :content => event_resource_xml 
    )
    RestAssured::Double.create(
      :fullpath => rdf_article_api_endpoint,
      :content => article_resource_xml 
    )
    RestAssured::Double.create(
      :fullpath => articles_person_query_endpoint,
      :content => articles_person_query_json 
    )
    RestAssured::Double.create(
      :fullpath => rdf_place_api_endpoint, 
      :content => place_resource_xml 
    )
  end

end
