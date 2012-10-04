require_relative 'learn_page_controller.rb'

class LearnPlacesPageController < LearnPageController 
  
  def initialize(id)

  end

  def run!
    page(:places,nil)          
  end

end
