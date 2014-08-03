# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expense do
    user
    date "2014-08-02"
    category
    description "MyString"
    currency ExchangeRate::CURRENCIES.sample
    amount 99.99
    status "Pending"
  end
end
