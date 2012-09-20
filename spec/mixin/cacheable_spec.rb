describe Cacheable, '#get' do
  let(:class_with_cacheable_module) {
    Class.new do
    include Cacheable
    end
  }

  subject { class_with_cacheable_module.new }

  it 'should return nil when no block is passed and no cached value is available' do
    cache = double("cache")
    cache.should_receive(:get).with(1).and_return(nil)

    value = subject.cache(1,cache)

    value.should be_nil
  end

  it 'should yield to the passed block where no cache is available' do
    cache = nil

    value = subject.cache(1,cache) { true }

    value.should be_true 
  end

  it 'should yield to the passed block where no cached value is available' do
    cache = double("cache")
    cache.should_receive(:get).with(1).and_return(nil)
    cache.should_receive(:set)

    value = subject.cache(1,cache) { true }

    value.should == true
  end

  it 'should query the cache for the passed id and return the value' do
    cache = double("cache")
    cache.should_receive(:get).with(1).and_return(true)

    value = subject.cache(1,cache) { false }

    value.should == true
  end

  it 'should set the cache when a block is passed and no cached value is available' do
    cache = double("cache")
    cache.should_receive(:get).ordered.with(1).and_return(nil)
    cache.should_receive(:set).ordered.with(1,true).and_return(true)

    subject.cache(1,cache) { true }
  end

end
