class Builder
 
  def build_array_of_type(type,key,parsed_json)
    concepts = Array.new
    if not parsed_json.kind_of?(Array) 
      return concepts
    end

    parsed_json.each { | item |
      instantiation_string = "#{type}.new(item['#{key}'])"
      concept = eval(instantiation_string)
      populate(concept)
      concepts.push(concept)
    }

    concepts

  end

  def populate(object)
    object.load!
    object.populate!
  end

end
