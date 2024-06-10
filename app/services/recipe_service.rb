class RecipeService
  def search_recipes(search_params)
    query = search_params.gsub(' ', '%20')
    get_url("?q=#{query}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.edamam.com/api/recipes/v2/") do |faraday|
      faraday.params["app_key"] = Rails.application.credentials.edamam[:key]
      faraday.params["app_id"] = Rails.application.credentials.edamam[:id]
      faraday.params["type"] = 'public'
    end
  end
end
