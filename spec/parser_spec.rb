require_relative '../models/parser.rb'
require_relative '../models/event.rb'

describe 'Parser' do
  
  it 'should fetch data from a given URI' do
    parser = Parser.new
    uri = 'http://testapi/data'
    
    event = parser.loadEvent(uri)
    
    event.should_not be_nil
    event.should be_an_instance_of(Event)
    
    # TODO Event is the return value object. The behaviour that populates it needs stubbed
    # event.name.should == 'Syria Crisis'
    # event.description.should == 'The Syria Crisis'
  end
  
  it 'should parse the fetched data and parse it into an event' do
    parser = Parser.new
    
    # TODO need to design the interaction of Parser.parse with Parser.loadEvent
    # perhaps loadEvent should call parse so it only needs to be a private method
    
  end
  
end