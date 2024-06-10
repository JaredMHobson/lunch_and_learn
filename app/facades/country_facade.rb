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
      name: country_data[:properties][:country],
      lon: country_data[:properties][:lon],
      lat: country_data[:properties][:lat]
    }
  end
end
