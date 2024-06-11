require 'rails_helper'

describe "Learning Resource Search API" do
  it "returns JSON data of a learning resource related to the searched country", :vcr do
    country  = 'thailand'

    get "/api/v1/learning_resources?country=#{country}"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    learning_resource_data = JSON.parse(response.body, symbolize_names: true)

    resource = learning_resource_data[:data]

    expect(resource).to have_key(:id)
    expect(resource[:id]).to be nil

    expect(resource).to have_key(:type)
    expect(resource[:type]).to eq('learning_resource')

    expect(resource).to have_key(:attributes)
    expect(resource[:attributes]).to be_a Hash

    expect(resource[:attributes]).to have_key(:country)
    expect(resource[:attributes][:country]).to eq(country)

    expect(resource[:attributes]).to have_key(:video)
    expect(resource[:attributes][:video]).to be_a Hash

    expect(resource[:attributes][:video]).to have_key(:title)
    expect(resource[:attributes][:video][:title]).to be_a String

    expect(resource[:attributes][:video]).to have_key(:youtube_video_id)
    expect(resource[:attributes][:video][:youtube_video_id]).to be_a String

    expect(resource[:attributes][:video]).to_not have_key(:id)
    expect(resource[:attributes][:video]).to_not have_key(:etag)
    expect(resource[:attributes][:video]).to_not have_key(:kind)
    expect(resource[:attributes][:video]).to_not have_key(:snippet)

    expect(resource[:attributes]).to have_key(:images)
    expect(resource[:attributes][:images]).to be_a Array
    expect(resource[:attributes][:images].count).to eq(10)

    resource[:attributes][:images].each do |image|
      expect(image).to have_key(:alt_tag)
      expect(image[:alt_tag]).to be_a String

      expect(image).to have_key(:url)
      expect(image[:url]).to be_a String

      expect(image).to_not have_key(:id)
      expect(image).to_not have_key(:slug)
      expect(image).to_not have_key(:blur_hash)
      expect(image).to_not have_key(:description)
    end
  end

  it "returns JSON data with an empty hash for video and an empty array for images if no matching results are found", :vcr do
    country  = 'aldjflkasdjflksjdafkl23flk23jflkjadsf'

    get "/api/v1/learning_resources?country=#{country}"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    learning_resource_data = JSON.parse(response.body, symbolize_names: true)

    resource = learning_resource_data[:data]

    expect(resource).to have_key(:id)
    expect(resource[:id]).to be nil

    expect(resource).to have_key(:type)
    expect(resource[:type]).to eq('learning_resource')

    expect(resource[:attributes]).to have_key(:country)
    expect(resource[:attributes][:country]).to eq(country)

    expect(resource[:attributes][:video]).to eq({})
    expect(resource[:attributes][:images]).to eq([])
  end
end
