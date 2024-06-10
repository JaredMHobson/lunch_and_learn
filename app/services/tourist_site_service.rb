class TouristSiteService
  def find_tourism_by_lon_lat(lon, lat)
    get_url("?categories=tourism&bias=proximity:#{lon},#{lat}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.geoapify.com/v2/places") do |faraday|
      faraday.params["apiKey"] = Rails.application.credentials.geoapify[:key]
    end
  end
end
