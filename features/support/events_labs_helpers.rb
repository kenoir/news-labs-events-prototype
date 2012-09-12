module EventsLabsHelpers
  require 'capybara'

  # Page validity
  def page_should_be_valid_events_page
    find('h1').should have_content('News')
    find('header.section h1').should have_content(parsed_event_json['title'])
  end

  def page_should_be_valid_news_page
    find('h1').should have_content('News')
  end

  def page_should_have_people_module
    page.should have_css('section.people')
  end

  def page_should_have_places_module
    page.should have_css('section.places')
  end

  def page_should_have_latest_articles_module
    page.should have_css('section.articles')
  end

  # People module
  def people_module_should_have_list_of_people
    within('section.people') do
      parsed_event_json['agents'] .each { |agent|
        page.should have_content(agent['label'])
      }
    end
  end

  # Latest articles module
  def latest_article_module_should_have_List_of_articles

  end
end


