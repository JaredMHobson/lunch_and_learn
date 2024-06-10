require 'rails_helper'

RSpec.describe "Country Facade" do
  it 'exists and has attributes' do
    facade = CountryFacade.new('india')

    expect(facade.instance_variable_get(:@service)).to be_a GeolocationService
    expect(facade.instance_variable_get(:@country)).to eq('india')
  end

  describe '#find_country_info' do
    it "returns a single country's geolocation info", :vcr do
      facade = CountryFacade.new('France')
      country = facade.find_country_info

      expect(country).to be_a Country
      expect(country.lon).to_not be_nil
      expect(country.lat).to_not be_nil
      expect(country.name).to_not be_nil
    end
  end
end
