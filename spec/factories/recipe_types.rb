FactoryBot.define do
  factory :recipe_type do
    sequence :name do |n|
      "MyString#{n}"
    end
  end
end
