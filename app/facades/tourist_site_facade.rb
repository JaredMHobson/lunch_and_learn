class TouristSiteFacade
  def initialize(lon, lat)
    @lon = lon
    @lat = lat
    @service = TouristSiteService.new
  end

  def find_tourist_sites_by_lon_lat
    results = @service.find_tourism_by_lon_lat(@lon, @lat)

    sites = results[:features]

    sites.map do |site_data|
      if site_data[:properties][:name]
        TouristSite.new(format_tourist_site_data(site_data))
      end
    end.compact[0..9]
  end

  private

  def format_tourist_site_data(tourist_site_data)
    {
      name: tourist_site_data[:properties][:name],
      address: tourist_site_data[:properties][:formatted],
      place_id: tourist_site_data[:properties][:place_id]
    }
  end
end
