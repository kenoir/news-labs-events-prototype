module Cacheable
  require 'dalli'

  def cache(id,cache = Application.cache)
    cached_value = cache.get(id) if not cache.nil?

    if not cached_value.nil?
      value = cached_value
    else
      if block_given?
        value = yield
        cache.set(id,value) if not cache.nil?
      end
    end

    value
  end

end
