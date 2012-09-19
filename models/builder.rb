class Builder
 
  def build_array_of_type(type,key,parsed_json)
    concepts = Array.new
    if not parsed_json.kind_of?(Array) 
      return concepts
    end

    parsed_json.each { | item |
      instantiation_string = "#{type}.new(item['#{key}'])"
      concept = eval(instantiation_string)
      if populate(concept)
        concepts.push(concept)
      end
    }

    concepts

  end

  def populate(object)
    succeeded = false

    begin
      object.load!
      object.populate!

      succeeded = true      
    rescue Exception => e
      puts "----------------------------------------------------------------\n"
      puts "Exception raised trying to load and populate rdf_sourced_object:\n"
      puts e.message
      puts e.backtrace.join("\n")
      puts "----------------------------------------------------------------\n"
    end

    succeeded
  end

end
