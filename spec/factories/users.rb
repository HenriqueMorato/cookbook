FactoryBot.define do
  factory :user do
    name 'Usuário'
    sequence(:email) { |n| "user#{n}@cookbook.com" }
    password '123456'
  end
end