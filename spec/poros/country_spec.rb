require 'rails_helper'

RSpec.describe "Country" do
  it 'exists and has attributes' do
    country_data = {
      name: 'country name',
      lon: 'country lon',
      lat: 'country lat'
    }

    country = Country.new(country_data)

    expect(country).to be_a Country
    expect(country.name).to eq('country name')
    expect(country.lon).to eq('country lon')
    expect(country.lat).to eq('country lat')
  end
end
