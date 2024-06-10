require 'rails_helper'

RSpec.describe "Tourist Site Service" do
  it 'exists' do
    service = TouristSiteService.new
    expect(service).to be_a TouristSiteService
  end

  describe '#conn' do
    it "establishes a Faraday connection" do
      service = TouristSiteService.new
      connection = service.conn

      expect(connection).to be_an_instance_of Faraday::Connection
      expect(connection.params["apiKey"]).to eq(Rails.application.credentials.geoapify[:key])
    end
  end

  describe '#get_url' do
    it "can access a URL and parse its returned JSON data", :vcr do
      service = TouristSiteService.new

      url = "?categories=tourism&bias=proximity:12.4934818,55.6939367"
      parsed_json = service.get_url(url)

      expect(parsed_json).to be_a Hash

      results = parsed_json[:features]

      expect(results).to be_a Array

      results.each do |place_info|
        if place_info[:properties][:name]
          expect(place_info[:properties]).to have_key(:name)
          expect(place_info[:properties]).to have_key(:formatted)
          expect(place_info[:properties]).to have_key(:place_id)
        end
      end
    end
  end

  describe '#find_tourism_by_lon_lat' do
    it "returns a list of tourist places near the passed lon and lat", :vcr do
      service = TouristSiteService.new
      results = service.find_tourism_by_lon_lat('12.4934818', '55.6939367')

      expect(results).to be_a Hash

      places = results[:features]

      expect(places).to be_a Array

      places.each do |place_info|
        if place_info[:properties][:name]
          expect(place_info[:properties]).to have_key(:name)
          expect(place_info[:properties]).to have_key(:formatted)
          expect(place_info[:properties]).to have_key(:place_id)
        end
      end
    end
  end
end
