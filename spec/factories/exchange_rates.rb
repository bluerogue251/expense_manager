# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exchange_rate do
    anchor "MyString"
    float "MyString"
    rate ""
    starts_on "2014-08-02"
  end
end
