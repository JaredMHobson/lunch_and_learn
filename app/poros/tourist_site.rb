class TouristSite
  attr_reader :id,
              :name,
              :address,
              :place_id

  def initialize(attributes)
    @id = nil
    @name = attributes[:name]
    @address = attributes[:address]
    @place_id = attributes[:place_id]
  end
end
