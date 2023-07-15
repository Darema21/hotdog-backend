# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# db/seeds.rb
require 'faker'

# Disable the transactional behavior to improve performance
ActiveRecord::Base.transaction do
  # Create owners
  owners = []

  5.times do
    owner = Owner.create(
      name: Faker::Name.name,
      age: Faker::Number.between(from: 18, to: 65),
      gender: Faker::Gender.binary_type,
      bio: Faker::Lorem.paragraph,
      wechat_id: Faker::Alphanumeric.alphanumeric(number: 6),
      active: true
    )

    owners << owner
  end

  # Create dogs and assign random owners
  10.times do
    owner = owners.sample

    Dog.create(
      name: Faker::Creature::Dog.name,
      gender: Faker::Creature::Dog.gender,
      age: Faker::Number.between(from: 1, to: 10),
      neutered: Faker::Boolean.boolean,
      vaccinated: Faker::Boolean.boolean,
      address: Faker::Address.full_address,
      bio: Faker::Lorem.paragraph,
      owner: owner
    )
  end

  puts "Seed data created successfully!"
end
