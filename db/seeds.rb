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
                  password_confirmation: "password",
                  activated: true,
                  activated_at: Time.zone.now)

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
                    password_confirmation: password,
                    activated: true,
                    activated_at: Time.zone.now)
end

# generate events for NGOs
ngos = Ngo.all
# generate 10 randon events for each NGO
10.times do
  name =        Faker::Lorem.sentence,
  start =       Faker::Date.forward(30),
  end_ =        Faker::Date.between(start, start),
  location =    Faker::Address.city
  description = Faker::Lorem.paragraph,
  occupancy =   Faker::Number.digit

  ngos.each { |ngo| ngo.events.create!(name: name, 
                                      start: start, 
                                      end: end_,
                                      location: location,
                                      description: description,
                                      occupancy: occupancy) }
end