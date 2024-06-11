require 'rails_helper'

RSpec.describe "Learning Video Service" do
  it 'exists' do
    service = LearningVideoService.new
    expect(service).to be_a LearningVideoService
  end

  describe '#conn' do
    it "establishes a Faraday connection" do
      service = LearningVideoService.new
      connection = service.conn

      expect(connection).to be_an_instance_of Faraday::Connection
      expect(connection.params["key"]).to eq(Rails.application.credentials.youtube[:key])
      expect(connection.params["part"]).to eq('snippet')
      expect(connection.params["channelId"]).to eq('UCluQ5yInbeAkkeCndNnUhpw')
      expect(connection.params["maxResults"]).to eq('1')
    end
  end

  describe '#get_url' do
    it "can access a URL and parse its returned JSON data", :vcr do
      service = LearningVideoService.new

      url = "?q=india"
      parsed_json = service.get_url(url)

      expect(parsed_json).to be_a Hash
      expect(parsed_json[:items]).to be_a Array
      expect(parsed_json[:items].first[:id]).to have_key(:videoId)
      expect(parsed_json[:items].first[:snippet]).to have_key(:title)
    end
  end

  describe '#search_videos' do
    it "returns a list of videos that match the argument search params", :vcr do
      service = LearningVideoService.new
      results = service.search_videos('india')

      expect(results).to be_a Hash
      expect(results[:items]).to be_a Array
      expect(results[:items].first[:id]).to have_key(:videoId)
      expect(results[:items].first[:snippet]).to have_key(:title)
    end
  end
end
