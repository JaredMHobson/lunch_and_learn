class Recipe
  attr_reader :title,
              :url,
              :country,
              :image

  def initialize(attributes)
    @title = attributes[:title]
    @url = attributes[:url]
    @country = attributes[:country]
    @image = attributes[:image]
  end
end
