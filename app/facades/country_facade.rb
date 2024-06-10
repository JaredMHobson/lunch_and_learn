class CountryFacade
  def initialize(country)
    @service = GeolocationService.new
    @country = country
  end

  def find_country_info
    results = @service.find_country_info(@country)

    country_data = results[:features].first

    Country.new(format_country_data(country_data))
  end

  private
  def format_country_data(country_data)
    {
      name: country_data[:country],
      lon: country_data[:lon],
      lat: country_data[:lat],
      place_id: country_data[:place_id]
    }
  end
end
