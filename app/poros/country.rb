class Country
  attr_reader :name,
              :lon,
              :lat

  def initialize(attributes)
    @name = attributes[:name]
    @lon = attributes[:lon]
    @lat = attributes[:lat]
  end
end
