class Country
  attr_reader :name,
              :lon,
              :lat,
              :place_id

  def initialize(attributes)
    @name = attributes[:name]
    @lon = attributes[:lon]
    @lat = attributes[:lat]
    @place_id = attributes[:place_id]
  end
end
