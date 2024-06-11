require 'rails_helper'

RSpec.describe "Learning Image Service" do
  it 'exists' do
    service = LearningImageService.new
    expect(service).to be_a LearningImageService
  end

  describe '#conn' do
    it "establishes a Faraday connection" do
      service = LearningImageService.new
      connection = service.conn

      expect(connection).to be_an_instance_of Faraday::Connection
      expect(connection.params["client_id"]).to eq(Rails.application.credentials.unsplash[:key])
    end
  end

  describe '#get_url' do
    it "can access a URL and parse its returned JSON data", :vcr do
      service = LearningImageService.new

      url = "?query=india"
      parsed_json = service.get_url(url)

      expect(parsed_json).to be_a Hash
      expect(parsed_json[:results]).to be_a Array
      expect(parsed_json[:results].first).to have_key(:alt_description)
      expect(parsed_json[:results].first).to have_key(:urls)
      expect(parsed_json[:results].first[:urls]).to have_key(:full)
    end
  end

  describe '#search_images' do
    it "returns a list of images that match the argument search params", :vcr do
      service = LearningImageService.new
      results = service.search_images('india')

      expect(results).to be_a Hash
      expect(results[:results]).to be_a Array

      results[:results].each do |result|
        expect(result).to have_key(:alt_description)
        expect(result).to have_key(:urls)
        expect(result[:urls]).to have_key(:full)
      end
    end
  end
end
