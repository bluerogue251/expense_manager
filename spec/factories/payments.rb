# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    user_id 1
    date "2014-08-06"
    currency "MyString"
    amount "9.99"
  end
end
