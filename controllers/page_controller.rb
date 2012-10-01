class PageController

  def domain
    raise NotImplementedError
  end

  def page(key,subject)
    page_hash = {
      key => subject,
      :domain => domain
    }

    if not subject.nil?
      subject.relations.each do | id, value |
        page_hash[id] = value.objects   
      end
    end

    page_hash
  end

end
