class LearningResource
  attr_reader :id,
              :country,
              :video,
              :images

  def initialize(attributes)
    @id = nil
    @country = attributes[:country]
    @video = attributes[:video]
    @images = attributes[:images]
  end
end
