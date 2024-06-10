class Recipe
  attr_reader :id,
              :title,
              :url,
              :country,
              :image

  def initialize(attributes)
    @id = nil
    @title = attributes[:title]
    @url = attributes[:url]
    @country = attributes[:country]
    @image = attributes[:image]
  end
end
