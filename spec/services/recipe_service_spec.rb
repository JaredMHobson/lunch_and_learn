require 'rails_helper'

RSpec.describe "Recipe Service" do
  describe '#conn' do
    it "establishes a Faraday connection" do
      service = RecipeService.new
      connection = service.conn

      expect(connection).to be_an_instance_of Faraday::Connection
      expect(connection.params["app_key"]).to eq(Rails.application.credentials.edamam[:key])
      expect(connection.params["app_id"]).to eq(Rails.application.credentials.edamam[:id])
      expect(connection.params["type"]).to eq('public')
    end
  end

  describe '#get_url' do
    it "can access a URL and parse its returned JSON data", :vcr do
      service = RecipeService.new

      url = "?q=india"
      parsed_json = service.get_url(url)

      expect(parsed_json).to be_a Hash
      expect(parsed_json[:hits]).to be_a Array
    end
  end

  describe '#search_recipes' do
    it "returns a list of recipes that match the argument search params", :vcr do
      service = RecipeService.new
      results = service.search_recipes('india')

      expect(results).to be_a Hash
      expect(results[:hits]).to be_a Array
      expect(results[:hits].first).to have_key(:recipe)
    end
  end
end
