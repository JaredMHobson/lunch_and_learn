require 'rails_helper'

RSpec.describe "Geolocation Service" do
  it 'exists' do
    service = GeolocationService.new
    expect(service).to be_a GeolocationService
  end

  describe '#conn' do
    it "establishes a Faraday connection" do
      service = GeolocationService.new
      connection = service.conn

      expect(connection).to be_an_instance_of Faraday::Connection
      expect(connection.params["apiKey"]).to eq(Rails.application.credentials.geoapify[:key])
    end
  end

  describe '#get_url' do
    it "can access a URL and parse its returned JSON data", :vcr do
      service = GeolocationService.new

      url = "?country=india"
      parsed_json = service.get_url(url)

      expect(parsed_json).to be_a Hash
      expect(parsed_json[:features]).to be_a Array
    end
  end

  describe '#find_country_info' do
    it "returns a hash of parsed JSON geolocation data about a country", :vcr do
      service = GeolocationService.new
      results = service.find_country_info('india')

      expect(results).to be_a Hash
      expect(results[:features]).to be_a Array
      expect(results[:features].first).to have_key(:properties)
      expect(results[:features].first[:properties]).to have_key(:lon)
      expect(results[:features].first[:properties]).to have_key(:lat)
      expect(results[:features].first[:properties]).to have_key(:country)
      expect(results[:features].first[:properties]).to have_key(:place_id)
    end
  end
end
