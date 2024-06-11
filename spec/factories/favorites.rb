FactoryBot.define do
  factory :favorite do
    country { "MyString" }
    recipe_link { "MyString" }
    recipe_title { "MyString" }
    association :user
  end
end
