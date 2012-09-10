class Event

  attr :uri
  attr :title, true
  attr :description, true

  def initialize(uri)
    @uri = uri
  end

end
