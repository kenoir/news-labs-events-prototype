class IndexController
  require 'mechanize'
  require 'hpricot'

  def run!
    agent = Mechanize.new
    page = agent.get('http://juicer.responsivenews.co.uk/events')

    @response = page.content
    doc = Hpricot(@response)

    @events = doc.at('div.events').inner_html
  end

end
