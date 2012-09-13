class IndexController
  require 'mechanize'
  require 'hpricot'

  def run!
    agent = Mechanize.new
    page = agent.get('http://juicer.responsivenews.co.uk/events')

    @response = page.content
    doc = Hpricot(@response)
    events_html = doc.at('div.events').inner_html
    
    @events = events_html.gsub("\/events","\/event")
  end

end
