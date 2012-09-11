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

  def rdf_resource_uri
    'http://dbpedia.org/resource/resource_name'
  end

  def rdf_api_endpoint
    "/rdf?identifier=#{rdf_resource_uri}"
  end

  def resource_xml_location
    File.join(File.dirname(__FILE__), '/data/resource.xml')
  end

  def resource_xml
    read_from_file(resource_xml_location)
  end

  def start_test_api
    RestAssured::Server.start(:port =>6666)
    RestAssured::Double.create(
      :fullpath => events_api_endpoint,
      :content => event_json
    )
    RestAssured::Double.create(
      :fullpath => rdf_api_endpoint,
      :content => resource_xml 
    )
  end
end
