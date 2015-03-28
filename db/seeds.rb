# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create 'fake' users in the db
Volunteer.create!(name: "Bill",
                  last_name: "Gates",
                  email: "billgates@test.com",
                  location: "California",
                  gender: "M",
                  password: "password",
                  password_confirmation: "password")

99.times do |n|
  name  = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.free_email(name)
  location = Faker::Address.city
  gender = "M",
  password = "password"
  Volunteer.create!(name: name,
                    last_name: last_name,
                    email: email,
                    gender: gender,
                    location: location,
                    password: password,
                    password_confirmation: password)
end