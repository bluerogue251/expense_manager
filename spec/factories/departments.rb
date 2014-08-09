# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :department do
    sequence(:name) { |n| "#{n} test department" }
  end
end
