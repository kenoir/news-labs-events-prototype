class Builder
  include Loggable
 
  def build_array_of_type(type,key,parsed_json)
    concepts = Array.new
    if not parsed_json.kind_of?(Array) 
      return concepts
    end
    
    begin 
      parsed_json.each do | item |
        instantiation_string = "#{type}.new(item['#{key}'])"
        concept = eval(instantiation_string)
        if populate(concept)
          concepts.push(concept)
        end
      end
    rescue Exception => e
      log("Exception raised trying to create list of concepts",e)
    end

    concepts

  end

  def populate(object_array)
    if not object_array.instance_of?(Array) 
      object_array = [object_array]
    end

    succeeded = true 

    object_array.each do | object |
      begin
        object.load!
        object.populate!

      rescue Exception => e
        log("Exception raised trying to load and populate rdf_sourced_object",e)
        succeeded = false 
      end
    end

    succeeded
  end

end
