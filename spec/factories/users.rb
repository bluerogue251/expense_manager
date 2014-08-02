# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@test.com" }
    name     "Teddy Widom"
    password "password"
  end
end
