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

  describe "Favorites Index" do
    it "returns an array of favorites for the user with the matching api key as data in a json" do
      user = create(:user)
      create_list(:favorite, 5, user: user)

      get "/api/v1/favorites?api_key=#{user.api_key}"

      favorites = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)

      favorites.each do |favorite|
        expect(favorite).to have_key(:id)
        expect(favorite[:id]).to be_an(String)

        expect(favorite).to have_key(:type)
        expect(favorite[:type]).to eq('favorite')

        expect(favorite[:attributes]).to have_key(:recipe_title)
        expect(favorite[:attributes][:recipe_title]).to be_an(String)

        expect(favorite[:attributes]).to have_key(:recipe_link)
        expect(favorite[:attributes][:recipe_link]).to be_an(String)

        expect(favorite[:attributes]).to have_key(:country)
        expect(favorite[:attributes][:country]).to be_an(String)

        expect(favorite[:attributes]).to have_key(:created_at)
        expect(favorite[:attributes][:created_at]).to be_an(String)
      end
    end

    it "returns an empty array of favorites for the user with the matching api key as data in a json if they dont have any favorites" do
      user = create(:user)

      get "/api/v1/favorites?api_key=#{user.api_key}"

      favorites = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(favorites).to be_a Array
      expect(favorites).to be_empty
    end

    it "returns a status of 404 and an appropriate error message if an invalid api key is passed" do
      get "/api/v1/favorites?api_key=adsjfkj23f23jflk23jf"

      data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect(data).to have_key(:errors)
      expect(data[:errors].first[:status]).to eq("404")
      expect(data[:errors].first[:title]).to eq("No user found with that API key")
    end
  end
end
