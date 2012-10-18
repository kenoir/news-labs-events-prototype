require_relative('loggable.rb')

module Cacheable
  require 'dalli'
  include Loggable

  def cache(id,cache = Application.cache)
    return if id.nil?

    begin
      cached_value = cache.get(id) if not cache.nil?
    rescue Exception => e
      log("Exception raised trying to use cache for #{id}",e)
    end

    if not cached_value.nil?
      value = cached_value
    else
      if block_given?
        value = yield
        begin
          cache.set(id,value) if not cache.nil?
        rescue Exception => e
          log("Exception raised trying to use cache for #{id}",e)
        end
      end
    end

    value
  end

end
