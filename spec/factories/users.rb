# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@test.com" }
    name     { Faker::Name.name }
    password { Faker::Internet.password }
    default_currency ExchangeRate::CURRENCIES.sample
  end
end
