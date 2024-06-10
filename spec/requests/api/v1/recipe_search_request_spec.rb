require 'rails_helper'

describe "Recipe Search API" do
  it "returns JSON data of recipes related to the searched country", :vcr do
    country  = 'thailand'

    get "/api/v1/recipes?country=#{country}"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    recipe_data = JSON.parse(response.body, symbolize_names: true)

    recipes = recipe_data[:data]

    expect(recipes).to be_a Array

    recipes.each do |recipe|
      expect(recipe).to have_key(:id)
      expect(recipe[:id]).to be nil

      expect(recipe).to have_key(:type)
      expect(recipe[:type]).to eq('recipe')

      expect(recipe).to have_key(:attributes)
      expect(recipe[:attributes]).to be_a Hash

      expect(recipe[:attributes]).to have_key(:title)
      expect(recipe[:attributes][:title]).to be_a String

      expect(recipe[:attributes]).to have_key(:url)
      expect(recipe[:attributes][:url]).to be_a String

      expect(recipe[:attributes]).to have_key(:country)
      expect(recipe[:attributes][:country]).to be_a String
      expect(recipe[:attributes][:country]).to eq(country)

      expect(recipe[:attributes]).to have_key(:image)
      expect(recipe[:attributes][:image]).to be_a String

      expect(recipe[:attributes]).to_not have_key(:uri)
      expect(recipe[:attributes]).to_not have_key(:label)
      expect(recipe[:attributes]).to_not have_key(:images)
      expect(recipe[:attributes]).to_not have_key(:source)
      expect(recipe[:attributes]).to_not have_key(:yield)
    end
  end

  it "returns JSON data with an empty array if empty search is passed", :vcr do
    country  = ''

    get "/api/v1/recipes?country=#{country}"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    recipe_data = JSON.parse(response.body, symbolize_names: true)

    recipes = recipe_data[:data]

    expect(recipes).to be_a Array
    expect(recipes).to be_empty
  end

  it "returns JSON data with an empty array if there are no matching results with the search", :vcr do
    country  = 'asdfjksdkfjlsdfjlkf23jfj23lk235j2l3k523'

    get "/api/v1/recipes?country=#{country}"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    recipe_data = JSON.parse(response.body, symbolize_names: true)

    recipes = recipe_data[:data]

    expect(recipes).to be_a Array
    expect(recipes).to be_empty
  end
end
