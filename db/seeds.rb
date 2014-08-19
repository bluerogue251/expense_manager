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
