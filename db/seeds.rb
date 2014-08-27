# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

category_names = [
  "Hotel",
  "Travel",
  "Meals",
  "Recreation",
  "Other benefit",
  "Equipment",
]
category_names.each { |category_name| Category.create!(name: category_name) }


department_names = [
  "Sales",
  "Purchasing",
  "Quality control",
  "Production",
  "R&D",
  "Accounting",
  "Executive"
]
department_names.each { |department_name| Department.create(name: department_name) }


job_title_names = [
  "Jr. associate",
  "Sr. associate",
  "Manager",
  "Auditor",
  "Engineer",
  "Sourcing specialist",
  "Jr. Accountant",
  "Sr. Accountant",
  "CEO",
  "CFO",
  "CTO"
]
job_title_names.each { |job_title_name| JobTitle.create(name: job_title_name) }


exchange_rates = [
  ["USD", "CNY", 6.10, "1900-01-01", "2015-01-01"],
  ["CNY", "USD", 0.16, "1900-01-01", "2015-01-01"],
  ["CNY", "HKD", 1.26, "1900-01-01", "2015-01-01"],
  ["HKD", "CNY", 0.79, "1900-01-01", "2015-01-01"],
  ["HKD", "USD", 0.13, "1900-01-01", "2015-01-01"],
  ["USD", "HKD", 7.75, "1900-01-01", "2015-01-01"],
  ["HKD", "CAD", 0.14, "1900-01-01", "2015-01-01"],
  ["CAD", "HKD", 7.12, "1900-01-01", "2015-01-01"],
  ["USD", "CAD", 1.09, "1900-01-01", "2015-01-01"],
  ["CAD", "USD", 0.92, "1900-01-01", "2015-01-01"]
]

exchange_rates.each do |anchor, float, rate, starts_on, ends_on|
  ExchangeRate.create!(anchor: anchor, float: float, rate: rate, starts_on: starts_on, ends_on: ends_on)
end

