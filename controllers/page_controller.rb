class PageController

  def domain
    raise NotImplementedError
  end

  def page(key,subject)
    {
      key => subject,
      :domain => domain
    }
  end

end
