class BaseController

  attr :domain

  def domain(id)
    case id 
    when "news"
      display_name = "News"
      body_class = "news"
    when "learn"
      display_name = "Learn"
      body_class = "learn"
    else
      throw :halt, [404, "Not found"]
    end

    {
      :display_name => display_name,
      :body_class => body_class
    }
  end

end
