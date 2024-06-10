require 'rails_helper'

RSpec.describe "Tourist Site" do
  it 'exists and has attributes' do
    site_data = {
      name: 'site name',
      address: 'site address',
      place_id: 'site place ID'
    }

    tourist_site = TouristSite.new(site_data)

    expect(tourist_site).to be_a TouristSite
    expect(tourist_site.name).to eq('site name')
    expect(tourist_site.address).to eq('site address')
    expect(tourist_site.place_id).to eq('site place ID')
  end
end
