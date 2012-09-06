module EventsLabsHelpers
  require 'capybara'

  def page_should_be_valid_news_page
    find('h1').should have_content('News')
  end

  def page_should_have_people_module
    page.should have_css('section.people')
  end

  def page_should_have_places_module
    page.should have_css('section.places')
  end

end
