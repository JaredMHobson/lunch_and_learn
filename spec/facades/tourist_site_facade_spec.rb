require 'rails_helper'

RSpec.describe "Tourist Site Facade" do
  it 'exists and has attributes' do
    facade = TouristSiteFacade.new('12.4934818', '55.6939367')

    expect(facade.instance_variable_get(:@service)).to be_a TouristSiteService
    expect(facade.instance_variable_get(:@lon)).to eq('12.4934818')
    expect(facade.instance_variable_get(:@lat)).to eq('55.6939367')
  end

  describe '#find_tourist_sites_by_lon_lat' do
    it "returns an array of 10 Tourist Site objects nearby the passed longitude and latitude", :vcr do
      facade = TouristSiteFacade.new('12.4934818', '55.6939367')
      results = facade.find_tourist_sites_by_lon_lat

      expect(results).to be_a Array

      results.each do |site|
        expect(site).to be_a TouristSite
        expect(site.name).to_not be_nil
        expect(site.address).to_not be_nil
        expect(site.place_id).to_not be_nil
      end
    end
  end
end
