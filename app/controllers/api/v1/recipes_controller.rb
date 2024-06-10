class Api::V1::RecipesController < ApplicationController
  def search
    recipes = RecipeFacade.new(search_params: params[:country]).search_recipes

    render json: RecipeSerializer.new(recipes)
  end
end
