require_relative 'page_controller.rb'

class IndexController < PageController
  require 'hpricot'
  require 'rest_client'

  def initialize(id)
    @domain_id = id

    super()
  end

  def run!
    if not ENV['REST_PROXY'].nil?
      RestClient.proxy = ENV['REST_PROXY']
    end

    response = RestClient.get('http://juicer.responsivenews.co.uk/events')

    @response = response.to_s 
    doc = Hpricot(@response)
    events_html = doc.at('div.events').inner_html
    
    @events = events_html.gsub("\/events","\/#{domain[:id]}\/events")

    page(:events,@events)
  end

  def domain
    case @domain_id
    when "news"
    domain = {
      :id => 'news',
      :display_name => "News", 
      :body_class => "news"
    }
    when "learn"
    domain = {
      :id => 'learn',
      :display_name => "Learn", 
      :body_class => "learn"
    }
    else
      raise "Unexpected Domain!"
    end

    domain
  end

end
