class LearningImageService
  def search_images(search_params)
    query = search_params.gsub(' ', '%20')
    get_url("?query=#{query}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.unsplash.com/search/photos") do |faraday|
      faraday.params["client_id"] = Rails.application.credentials.unsplash[:key]
    end
  end
end
