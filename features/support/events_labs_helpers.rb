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
  def latest_article_module_should_have_list_of_articles
    within('section.articles') do
      parsed_event_json['articles'].each { |article|
        page.should have_content(article['title'])
        page.should have_xpath "//a[contains(@href,'#{article['url']}')]"
      }
    end
  end

  def person_should_have_a_list_of_articles
    within('section.people ul li section.articles') do
      # http://juicer.responsivenews.co.uk/articles/19485798.json
      # Need to get for above
      parsed_article_json['articles'].each { |article|
        page.should have_content(article['title'])
        page.should have_xpath "//a[contains(@href,'#{article['url']}')]"
      }
    end
  end

  # Places module
  def places_module_should_have_list_of_people
    within('section.places') do
      parsed_event_json['places'].each { | place |
        page.should have_content(place['label'])
      page.should have_xpath "//a[contains(@href,'#{place['uri']}')]"
      }
    end
  end

  module BigTestsHelper
    require 'rest_client'
    require 'json'

    def self.juicer_api_url
      'http://juicer.responsivenews.co.uk/events'
    end

    def self.app_event_base_uri
      'http://news-labs-events-prototype.herokuapp.com/event/'
    end

    def self.all_available_events
      RestClient.proxy = ENV['CUKES_REST_PROXY'] 
      response = RestClient.get juicer_api_url, :accept => 'application/json'

      events_json = response.to_str
      parsed_events_json = JSON.parse(events_json)

      parsed_events_json
    end

    def self.all_responses_should_be_successful(responses)
      all_succeeded = true
      responses.each do | response |
        if not response[:success]
          all_succeeded = false
          puts "Failed: #{response.inspect}"
        end
      end

      all_succeeded.should be true
    end

    def self.visit_events(events)
      RestClient.proxy = ENV['CUKES_REST_PROXY']

      responses = Array.new

      events.each do | event |
        event_uri = "#{app_event_base_uri}#{event["id"].to_s}"

      response = { 
        :title => event["title"], 
        :id => event["id"],
        :success => true
      }

      begin
        RestClient.get event_uri
      rescue
        response[:success] = false;
      end

      responses.push(response)
      end

      responses
    end
  end
end
