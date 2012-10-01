require_relative 'learn_page_controller.rb'

class LearnPeoplePageController < LearnPageController 
  
  def initialize(id)

  end

  def run!
    page(:people,nil)          
  end

end
