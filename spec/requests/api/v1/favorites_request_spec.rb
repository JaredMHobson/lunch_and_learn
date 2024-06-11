require 'rails_helper'

RSpec.describe "Favorites API", type: :request do
  describe "Favorites Create" do
    it "creates a favorite for the user with the associated api_key and returns an appropriate message" do
      user = create(:user)

      favorite_params = {
          "api_key": "#{user.api_key}",
          "country": "thailand",
          "recipe_link": "https://www.tastingtable.com/",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/favorites", params: JSON.generate(favorite_params), headers: headers

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(data).to have_key(:success)
      expect(data[:success]).to eq("Favorite added successfully")
    end

    it "returns a status of 404 and an appropriate error message if an invalid api key is passed" do
      favorite_params = {
          "api_key": "wrong_api_key",
          "country": "thailand",
          "recipe_link": "https://www.tastingtable.com/",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/favorites", params: JSON.generate(favorite_params), headers: headers

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect(data).to have_key(:errors)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("No user found with that API key")
    end
  end
end
