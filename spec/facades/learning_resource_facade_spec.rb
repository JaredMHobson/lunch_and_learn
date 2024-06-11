require 'rails_helper'

RSpec.describe "Learning Resource Facade" do
  it 'exists and has attributes' do
    facade = LearningResourceFacade.new('india')

    expect(facade.instance_variable_get(:@video_service)).to be_a LearningVideoService
    expect(facade.instance_variable_get(:@image_service)).to be_a LearningImageService
    expect(facade.instance_variable_get(:@country)).to eq('india')
  end

  describe '#learning_resource_for_country' do
    it "returns a single LearningResource for the country passed on initialization", :vcr do
      country = 'india'

      facade = LearningResourceFacade.new(country)
      result = facade.learning_resource_for_country

      expect(result).to be_a LearningResource

      expect(result.id).to be nil
      expect(result.country).to eq(country)
      expect(result.video).to_not be nil
      expect(result.video).to be_a Hash
      expect(result.images).to_not be nil
      expect(result.images).to be_a Array
      expect(result.images.count).to eq(10)
    end

    it 'returns an empty hash for video if no videos are found for that country', :vcr do
      country = 'ajdslakasjdlfkjlk2334023jkldf'

      facade = LearningResourceFacade.new(country)
      result = facade.learning_resource_for_country

      expect(result).to be_a LearningResource
      expect(result.video).to eq({})
    end

    it 'returns an empty array for images if no images are found for that country', :vcr do
      country = 'ajdslakasjdlfkjlk2334023jkldf'

      facade = LearningResourceFacade.new(country)
      result = facade.learning_resource_for_country

      expect(result).to be_a LearningResource
      expect(result.images).to eq([])
    end
  end
end
