# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

User.create!(name: 'Teddy Widom', email: 'theodore.widom@gmail.com', password: 'password')

category_names = [
  "Hotel",
  "Travel",
  "Meals",
  "Recreation",
  "Other benefit",
  "Equipment",
]

category_names.each { |category_name| Category.create!(name: category_name) }
