require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'validations' do
    it { should validate_presence_of :country }
    it { should validate_presence_of :recipe_link }
    it { should validate_presence_of :recipe_title }
  end

  describe 'associations' do
    it { should belong_to :user }
  end

  it 'exists and has attributes' do
    favorite_data = {
      "country": "thailand",
      "recipe_link": "https://www.tastingtable.com/",
      "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
    }

    user = create(:user)
    favorite = user.favorites.create(favorite_data)

    expect(favorite).to be_a Favorite
    expect(favorite.country).to eq('thailand')
    expect(favorite.recipe_link).to eq('https://www.tastingtable.com/')
    expect(favorite.recipe_title).to eq('Crab Fried Rice (Khaao Pad Bpu)')
  end
end
