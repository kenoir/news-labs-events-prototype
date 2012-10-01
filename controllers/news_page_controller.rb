require_relative 'page_controller.rb'

class NewsPageController < PageController

  def domain 
    {
      :id => 'news',
      :display_name => "News", 
      :body_class => "news"
    }
  end

end
