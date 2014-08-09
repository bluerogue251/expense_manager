# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job_title do
    sequence(:name) { |n| "#{n} test job title" }
  end
end
