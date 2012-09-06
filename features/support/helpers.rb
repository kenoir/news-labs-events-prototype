module Helpers
  require 'capybara'

  def page_should_be_valid_news_page
    find('h1').should have_content('News')
  end
end
