module Cacheable
  require 'dalli'

  def get(id,cache = Application.cache)
    if not cache.nil?
      cached_value = cache.get(id)
    end

    if not cached_value.nil?
      value = cached_value
    else
      value = yield
    end

    value
  end

  def set(id)

  end
end
