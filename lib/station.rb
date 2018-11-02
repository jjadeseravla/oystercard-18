class Station

  DEFAULT_ZONE = 1
  attr_reader :name

  def initialize(name, zone = DEFAULT_ZONE)
    @name = name
    @zone = zone
  end

  def check_zone
    @zone
  end

end
