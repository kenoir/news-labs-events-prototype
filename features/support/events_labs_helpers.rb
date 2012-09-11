require 'json'

module EventsLabsHelpers
  require 'capybara'

  # Page validity
  def page_should_be_valid_events_page
    find('h1').should have_content('News')
    find('header.section h1').should have_content(event['title'])
    find('article.intro p').should have_content(event['description'])
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

  # People module
  def people_module_should_have_list_of_people
    within('section.people') do
      event['agents'] .each { |agent|
        page.should have_content(agent['label'])
      }
    end
  end

end

# Methods for rest assured
def events_endpoint
  '/events/1'
end

def events_json
  file_location = File.join(File.dirname(__FILE__), '..', '..', 'data/events/1.json')
  file = File.open(file_location, "rb")
  contents = file.read
end

def event 
  event = JSON.parse(events_json)

  event
end

