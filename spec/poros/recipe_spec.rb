require 'rails_helper'

RSpec.describe "Recipe" do
  it 'exists and has attributes' do
    recipe_data = {
      title: 'Recipe Title',
      url: 'Recipe URL',
      country: 'Recipe Country',
      image: 'Recipe Image'
    }

    recipe = Recipe.new(recipe_data)

    expect(recipe).to be_a Recipe
    expect(recipe.title).to eq('Recipe Title')
    expect(recipe.url).to eq('Recipe URL')
    expect(recipe.country).to eq('Recipe Country')
    expect(recipe.image).to eq('Recipe Image')
  end
end
