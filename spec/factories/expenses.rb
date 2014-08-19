# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expense do
    user
    date random_date
    category
    description { Faker::Commerce.product_name }
    currency { ExchangeRate::CURRENCIES.sample }
    amount { Faker::Number.number(3) }
    status { Expense::STATUSES.sample }
  end
end
