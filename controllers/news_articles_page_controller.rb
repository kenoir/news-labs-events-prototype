require_relative 'news_page_controller.rb'

class NewsArticlesPageController < NewsPageController

  def initialize(id)

  end

  def run!
    page(:article,nil)
  end

end
