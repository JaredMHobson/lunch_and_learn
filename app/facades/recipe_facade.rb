class RecipeFacade
  def initialize(search_params: nil)
    @search_params = search_params
    @service = RecipeService.new
  end

  def search_recipes
    if @search_params == ""
      Array.new
    else
      results = @service.search_recipes(@search_params)

      if results[:count] == 0
        Array.new
      else
        results[:hits].map do |recipe_data|
          Recipe.new(format_recipe_data(recipe_data))
        end
      end
    end
  end

  private

  def format_recipe_data(recipe_data)
    {
      title: recipe_data[:recipe][:label],
      url: recipe_data[:recipe][:url],
      country: @search_params,
      image: recipe_data[:recipe][:image]
    }
  end
end
