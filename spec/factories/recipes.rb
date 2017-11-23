FactoryBot.define do
  factory :recipe do
    sequence :title do |n|
      "Feijoada #{n}"    
    end
    difficulty "MyString"
    cook_time 1
    ingredients 'MyString'
    cook_method 'MyString'
    
    recipe_type
    cuisine
    user
  end
end
