class LearningResourceFacade
  def initialize(country)
    @country = country
    @video_service = LearningVideoService.new
    @image_service = LearningImageService.new
  end

  def learning_resource_for_country
    video_data = @video_service.search_videos(@country)
    image_data = @image_service.search_images(@country)

    learning_resource_data = {
      country: @country,
      video: format_video_data(video_data),
      images: format_image_data(image_data)
    }

    LearningResource.new(learning_resource_data)
  end

  private
  def format_video_data(video_data)
    if video_data[:items].empty?
      Hash.new
    else
      {
        title: video_data[:items].first[:snippet][:title],
        youtube_video_id: video_data[:items].first[:id][:videoId]
      }
    end
  end

  def format_image_data(image_data)
    if image_data[:results].empty?
      Array.new
    else
      image_data[:results].map do |data|
        {
          alt_tag: data[:alt_description],
          url: data[:urls][:full]
        }
      end
    end
  end
end
