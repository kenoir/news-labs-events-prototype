class PageController

  attr :builder, true
  attr :id,true

  def initialize(id = nil)
    @id = id
    @builder = Builder.new
  end

  def domain
    raise NotImplementedError
  end

  def page(key,subject)
    page_hash = {
      key => subject,
      :domain => domain
    }

    if not subject.nil? and defined? subject.relations
      subject.relations.each do | id, value |
        page_hash[id] = value.objects   
      end
    end

    page_hash
  end

end
