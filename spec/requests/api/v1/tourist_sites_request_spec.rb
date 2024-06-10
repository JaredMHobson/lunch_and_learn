require 'rails_helper'

describe "Tourist Sites API" do
  it "returns JSON data of sites related to the query param country", :vcr do
    country  = 'France'

    get "/api/v1/tourist_sites?country=#{country}"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    site_data = JSON.parse(response.body, symbolize_names: true)

    sites = site_data[:data]

    expect(sites).to be_a Array
    expect(sites.count).to eq(10)

    sites.each do |site|
      expect(site).to have_key(:id)
      expect(site[:id]).to be nil

      expect(site).to have_key(:type)
      expect(site[:type]).to eq('tourist_site')

      expect(site).to have_key(:attributes)
      expect(site[:attributes]).to be_a Hash

      expect(site[:attributes]).to have_key(:name)
      expect(site[:attributes][:name]).to be_a String

      expect(site[:attributes]).to have_key(:address)
      expect(site[:attributes][:address]).to be_a String

      expect(site[:attributes]).to have_key(:place_id)
      expect(site[:attributes][:place_id]).to be_a String
    end
  end
end
