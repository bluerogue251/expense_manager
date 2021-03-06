# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exchange_rate do
    anchor "USD"
    float "CNY"
    rate 6
    starts_on "1500-01-01"
    ends_on "3000-01-01"
  end
end
