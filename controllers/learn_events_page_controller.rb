require_relative 'learn_page_controller.rb'

class LearnEventsPageController < LearnPageController 
  
  def initialize(id)

  end

  def run!
    page(:event,nil)          
  end

end
