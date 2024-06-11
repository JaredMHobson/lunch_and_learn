class LearningVideoService
  def search_videos(search_params)
    query = search_params.gsub(' ', '%20')
    get_url("?q=#{query}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://www.googleapis.com/youtube/v3/search") do |faraday|
      faraday.params["key"] = Rails.application.credentials.youtube[:key]
      faraday.params["part"] = 'snippet'
      faraday.params["channelId"] = 'UCluQ5yInbeAkkeCndNnUhpw'
      faraday.params["maxResults"] = '1'
    end
  end
end
