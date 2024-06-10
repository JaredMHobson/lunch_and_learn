class GeolocationService
  def find_country_info(country)
    get_url("?country=#{country}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.geoapify.com/v1/geocode/search") do |faraday|
      faraday.params["apiKey"] = Rails.application.credentials.geoapify[:key]
    end
  end
end
