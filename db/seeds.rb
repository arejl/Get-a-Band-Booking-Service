# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require 'Faker'
Booking.destroy_all
Availability.destroy_all
Artist.destroy_all
User.destroy_all
Location.destroy_all

# Admin
1.times do
  admin = User.create!(
    first_name: "getabandadmin",
    last_name: Faker::Name.last_name,
    email: "getabandadmin@yopmail.com",
    password: "azerty",
    admin: true,
  )
  puts "Create Admin"
end

# User
10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Name.first_name + "@yopmail.com",
    password: "azerty",
  )
  puts "Create User"
end

#Location
["Oise", "Val-d'oise", "Finistère", "Bouches-du-Rhône", "Paris"].each do |departement|
  location = Location.create!(
    department: departement,
  )
  puts "Create location"
end

#Artists
10.times do
  artist = Artist.create!(
    artist_name: Faker::Kpop.iii_groups,
    description: Faker::Lorem.sentence(word_count: 8),
    hourly_price: 50,
    email: Faker::Name.first_name + "@yopmail.com",
    password: "azerty",
    location: Location.all.sample,
    status: "approved",

  )
  puts "Create Artist"
end

#Availability
index = Artist.first.id
10.times do
  start_date = Faker::Time.between(from: DateTime.now, to: DateTime.now + 100)
  availability = Availability.create!(
    start_date: start_date,
    end_date: start_date + rand(1..20).days,
    artist: Artist.find(index),
  )
  puts "Create Availability"
  index += 1
end

#Booking
index = User.first.id
Availability.all.each do |available_slot|
  Booking.create!(
    start_date: Faker::Time.between(from: available_slot.start_date, to: available_slot.end_date-1.day, format: :default),
    duration: 24,
    description: Faker::Lorem.sentence(word_count: 8),
    user: User.find(index),
    availability: available_slot,
    status: ["pending", "approved"].sample,
  )
  puts "Create booking"
  index += 1
end
