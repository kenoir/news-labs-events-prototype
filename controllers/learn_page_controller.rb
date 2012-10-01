require_relative 'page_controller.rb'

class LearnPageController < PageController

  def domain
    {
      :id => 'learn',
      :display_name => "Learn", 
      :body_class => "learn"
    }
  end

end
