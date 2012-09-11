require_relative './rdf_sourced_object'

class Event < RDFSourcedObject

  attr :people, true
  attr :title, true
  attr :description, true

end
