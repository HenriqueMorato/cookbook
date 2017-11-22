FactoryBot.define do
  factory :cuisine do
    sequence :name do |n|
      "MyString#{n}"
    end
  end
end
