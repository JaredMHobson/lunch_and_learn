require 'rails_helper'

RSpec.describe "Recipe Facade" do
  it 'exists and has attributes' do
    facade = RecipeFacade.new

    expect(facade.instance_variable_get(:@service)).to be_a RecipeService
    expect(facade.instance_variable_get(:@search_params)).to eq nil
  end

  describe '#search_recipes' do
    it "returns an array of Recipe objects", :vcr do
      facade = RecipeFacade.new(search_params: 'india')
      results = facade.search_recipes

      expect(results).to be_a Array

      results.each do |result|
        expect(result).to be_a Recipe
      end
    end

    it 'returns an empty array if the search params are empty', :vcr do
      facade = RecipeFacade.new(search_params: '')
      results = facade.search_recipes

      expect(results).to be_a Array
      expect(results).to be_empty
    end

    it 'returns an empty array if the search does not return any results', :vcr do
      facade = RecipeFacade.new(search_params: 'aklsdjflksdjflkj2ljf30fjkoadsjfkl2323f')
      results = facade.search_recipes

      expect(results).to be_a Array
      expect(results).to be_empty
    end
  end
end
