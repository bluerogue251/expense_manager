# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job_title_assignment do
    user
    job_title
    department
    starts_on "1500-01-01"
    ends_on "3000-01-01"
  end
end
