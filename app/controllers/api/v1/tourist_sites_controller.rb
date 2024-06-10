class Api::V1::TouristSitesController < ApplicationController
  def search
    country = CountryFacade.new(params[:country]).find_country_info

    tourist_sites = TouristSiteFacade.new(country.lon, country.lat).find_tourist_sites_by_lon_lat

    render json: TouristSiteSerializer.new(tourist_sites)
  end
end
