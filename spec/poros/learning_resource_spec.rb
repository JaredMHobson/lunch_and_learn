require 'rails_helper'

RSpec.describe "Learning Resource" do
  it 'exists and has attributes' do
    learning_resource_data = {
      id: nil,
      country: 'Country Name',
      video: {title: 'Video Title', youtube_video_id: 'abc123'},
      images: [
        {alt_tag: 'Image 1 Alt Tag', url: 'Image 1 Url'},
        {alt_tag: 'Image 2 Alt Tag', url: 'Image 2 Url'},
        {alt_tag: 'Image 3 Alt Tag', url: 'Image 3 Url'},
      ]
    }

    resource = LearningResource.new(learning_resource_data)

    expect(resource).to be_a LearningResource
    expect(resource.id).to be nil
    expect(resource.country).to eq('Country Name')
    expect(resource.video).to eq({title: 'Video Title', youtube_video_id: 'abc123'})
    expect(resource.images).to eq([
      {alt_tag: 'Image 1 Alt Tag', url: 'Image 1 Url'},
      {alt_tag: 'Image 2 Alt Tag', url: 'Image 2 Url'},
      {alt_tag: 'Image 3 Alt Tag', url: 'Image 3 Url'},
    ])
  end
end
