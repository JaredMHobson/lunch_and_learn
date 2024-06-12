class Favorite < ApplicationRecord
  validates :country, presence: true
  validates :recipe_link, presence: true
  validates :recipe_title, presence: true

  belongs_to :user
end
