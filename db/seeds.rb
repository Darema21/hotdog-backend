# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# db/seeds.rb
require 'json'
require 'open-uri'

# Breed descriptions
breed_data = [
  { name: 'Beagle', image: 'app/assets/images/breeds/beagle.png', description: 'The Beagle is a small to medium-sized dog breed known for its distinctive appearance and keen sense of smell. With its short, sleek coat and droopy ears, the Beagle is an adorable and friendly companion. They are often characterized by their playful and curious nature, making them great family pets.' },
  { name: 'Bulldog', image: 'app/assets/images/breeds/american_bulldog.png', description: 'The Bulldog, also known as the English Bulldog, is a sturdy and muscular dog breed with a distinctive wrinkled face and a determined expression. Despite their tough appearance, Bulldogs are known for their gentle and affectionate nature, making them excellent family pets. They are generally calm and docile, preferring a relaxed lifestyle over vigorous exercise.' },
  { name: 'Chihuahua', image: 'app/assets/images/breeds/chihuahua.png', description: 'The Chihuahua is a tiny and lively dog breed known for its sassy personality and big personality. These pint-sized canines are often characterized by their large, round eyes and delicate features. Chihuahuas are highly devoted to their owners and thrive on companionship. Despite their small size, they are often fearless and confident, sometimes even displaying a bit of an attitude.' },
  { name: 'Corgi', image: 'app/assets/images/breeds/corgi.png', description: 'The Corgi, specifically the Pembroke Welsh Corgi, is a small herding dog breed that is known for its adorable appearance and lively personality. They have a distinct body structure with short legs and a long torso. Corgis are highly intelligent and eager to please, making them easy to train. They are often energetic and playful, enjoying activities such as fetch and agility training.' },
  { name: 'French Bulldog', image: 'app/assets/images/breeds/french_bulldog.png', description: 'The French Bulldog, or Frenchie, is a small and compact dog breed with a unique appearance and a charming personality. With their bat-like ears and expressive eyes, French Bulldogs are instantly recognizable. They have a friendly and affectionate disposition and are known for being great companions. Despite their small size, French Bulldogs have a sturdy build and a playful nature.' },
  { name: 'German Shepherd', image: 'app/assets/images/breeds/german_shepherd.png', description: 'The German Shepherd is a large and noble dog breed renowned for its intelligence, loyalty, and versatility. These dogs are highly trainable and often serve in various roles such as police dogs, search and rescue dogs, and guide dogs. German Shepherds have a strong protective instinct and make excellent guard dogs.' },
  { name: 'Golden Retriever', image: 'app/assets/images/breeds/golden_retriever.png', description: 'The Golden Retriever is a friendly and intelligent dog breed that is beloved for its gentle nature and loyalty. With their luxurious golden coat and friendly expression, they are often considered one of the most beautiful and iconic dog breeds. Golden Retrievers are highly adaptable and excel in various roles, including family pets, therapy dogs, and search and rescue dogs.' },
  { name: 'Husky', image: 'app/assets/images/breeds/husky.png', description: 'The Husky is a medium to large-sized working dog breed that is famous for its striking appearance and sled-pulling abilities. Huskies have a dense double coat, erect ears, and captivating blue or multi-colored eyes. They are known for their endurance and agility, making them ideal for activities like sledding and skijoring.' },
  { name: 'Labrador', image: 'app/assets/images/breeds/labrador.png', description: 'The Labrador Retriever, often referred to as Lab, is a popular and versatile dog breed known for its friendly nature, intelligence, and loyalty. Labs have a sturdy and athletic build, making them excellent companions for outdoor activities and sports. They are highly trainable and often serve as service dogs, therapy dogs, and search and rescue dogs.' },
  { name: 'Parson Russell Terrier', image: 'app/assets/images/breeds/parson_russell_terrier.png', description: 'The Parson Russell Terrier is a small, energetic, and intelligent breed. With its compact, muscular body and lively expression, it is an attractive and charming dog. Known for its alertness and attentiveness, the Parson Russell Terrier is always ready to explore and investigate its surroundings. It has a distinctive wiry coat that comes in various colors, such as white, white with tan or black markings, or tricolor. This breed is highly active and requires regular exercise to stay happy and healthy.' },
  { name: 'Pug', image: 'app/assets/images/breeds/pug.png', description: 'The Pug is a small dog breed known for its distinctive appearance, with a wrinkled face, a curly tail, and large, expressive eyes. Pugs have a charming and mischievous personality, making them excellent companions for families and individuals. They have a friendly and affectionate nature, often seeking attention and close contact with their owners.' },
  { name: 'Poodle (Toy)', image: 'app/assets/images/breeds/toy_poodle.png', description: 'The Toy Poodle is a small and elegant dog breed known for its intelligence, agility, and delightful personality. With their curly and dense coat, they are often considered one of the most hypoallergenic dog breeds. Toy Poodles are highly trainable and excel in activities such as obedience, agility, and even therapy work.' }
]
Breed.destroy_all

# Creating breeds
api_key = Rails.application.credentials.dig(:ninjas, :key)
breed_data.each do |breed_info|
  breed_name = breed_info[:name]
  puts "Creating #{breed_name}"
  breed_description = breed_info[:description]

  # breed_image = URI.open(breed_info[:image])
  breed_image = open(breed_info[:image])
  breed = Breed.create(name: breed_name, description: breed_description)
  breed.image.attach(io: breed_image, filename: "#{breed_name.downcase.gsub(' ', '_')}.png", content_type: 'image/png')

  begin
    base_url = "https://api.api-ninjas.com/v1/dogs?name="
    url = "#{base_url}#{breed_name}"
    response = URI.open(url, 'X-Api-Key' => 'Cqi1z+e5/4SUPNJX4yz3gA==RnQVVVLkceE3dqQC').read
    breed_data_array = JSON.parse(response)

    if breed_data_array.nil? || breed_data_array.empty?
      puts "No data found for breed #{breed_name}."
    else
      breed_data = breed_data_array.first
      breed.update(
        good_with_children: breed_data['good_with_children'],
        good_with_other_dogs: breed_data['good_with_other_dogs'],
        shedding: breed_data['shedding'],
        grooming: breed_data['grooming'],
        drooling: breed_data['drooling'],
        coat_length: breed_data['coat_length'],
        good_with_strangers: breed_data['good_with_strangers'],
        playfulness: breed_data['playfulness'],
        protectiveness: breed_data['protectiveness'],
        trainability: breed_data['trainability'],
        energy: breed_data['energy'],
        barking: breed_data['barking'],
        min_life_expectancy: breed_data['min_life_expectancy'],
        max_life_expectancy: breed_data['max_life_expectancy'],
        max_height_male: breed_data['max_height_male'],
        max_height_female: breed_data['max_height_female'],
        max_weight_male: breed_data['max_weight_male'],
        max_weight_female: breed_data['max_weight_female'],
        min_height_male: breed_data['min_height_male'],
        min_height_female: breed_data['min_height_female'],
        min_weight_male: breed_data['min_weight_male'],
        min_weight_female: breed_data['min_weight_female']
      )
    end
  rescue StandardError => e
    puts "Error seeding breed #{breed_name}: #{e.message}"
  end
end
require 'faker'
require 'json'
require 'open-uri'

# dog_url = "https://api.unsplash.com/search/photos?query=dog&client_id=vxJlLu9p1P2BcV2Aqq0DgLT1owhw_O14_qtCH461gnE"
# owner_url = "https://api.unsplash.com/search/photos?query=person&client_id=vxJlLu9p1P2BcV2Aqq0DgLT1owhw_O14_qtCH461gnE"

# Function to download an image from the given URL
def download_image(url)
  open(url) { |image| image.read }
end

# URLs for specific dog and owner images
# dog_image_urls = [
#   "https://images.unsplash.com/photo-1518374835801-2c7d993de05c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80",
#   "https://images.unsplash.com/photo-1583511655802-41f2ccc2cc8f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTQxfHxkb2d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
#   "https://images.unsplash.com/photo-1562714529-94d65989df68?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTI2fHxkb2d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
#   "https://images.unsplash.com/photo-1612940960267-4549a58fb257?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTE3fHxkb2d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
#   "https://images.unsplash.com/photo-1572566830488-069bcc7fbcec?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTE1fHxkb2d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
#   "https://images.unsplash.com/photo-1618173745201-8e3bf8978acc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTEwfHxkb2d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
#   "https://images.unsplash.com/photo-1588269864631-ced7dff8da0d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OTN8fGRvZ3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
#   "https://images.unsplash.com/photo-1534351450181-ea9f78427fe8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTAyfHxkb2d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60"
# ]

# owner_image_urls = [
#   "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1748&q=80",
#   "https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTExfHxwZXJzb258ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
#   "https://images.unsplash.com/photo-1589696485114-9e2f81d83484?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTIyfHxwZXJzb258ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
#   "https://images.unsplash.com/photo-1549068106-b024baf5062d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTA0fHxwZXJzb258ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
#   "https://images.unsplash.com/photo-1530268729831-4b0b9e170218?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OTl8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
#   "https://images.unsplash.com/photo-1525875975471-999f65706a10?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OTR8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
#   "https://images.unsplash.com/photo-1506863530036-1efeddceb993?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8ODl8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
#   "https://images.unsplash.com/photo-1615813967515-e1838c1c5116?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTN8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60"
# ]

# Create owners
puts "Creating Owners"
owners = []

10.times do |i|
  owner = Owner.create(
    name: Faker::Name.name,
    age: Faker::Number.between(from: 18, to: 65),
    gender: Faker::Gender.binary_type,
    bio: Faker::Lorem.paragraph,
    wechat_id: Faker::Alphanumeric.alphanumeric(number: 6),
    active: true
  )

  # Attach owner photo using the specified URL
  # owner_photo_url = owner_image_urls[i]
  # owner.photo.attach(io: download_image(owner_photo_url), filename: "#{owner.name.parameterize}_owner.jpg", content_type: 'image/jpeg')

  owners << owner
end

puts "Created #{owners.length} owners"

# Create dogs and assign each dog to a unique owner
puts "Creating Dogs"
breeds = Breed.all

dogs = []

owners.each do |owner|
  puts "Creating Dogs for #{owner.name}"
  breed = breeds.sample
  1.times do
    dog = Dog.create(
      name: Faker::Creature::Dog.name,
      gender: Faker::Creature::Dog.gender,
      age: Faker::Number.between(from: 1, to: 10),
      neutered: Faker::Boolean.boolean,
      vaccinated: Faker::Boolean.boolean,
      address: Faker::Address.full_address,
      bio: Faker::Lorem.paragraph,
      owner: owner,
      breed: breed
    )

    # Attach dog photo using the specified URL
    # dog_photo_url = dog_image_urls.sample
    # dog.images.attach(io: download_image(dog_photo_url), filename: "#{dog.name.parameterize}_dog.jpg", content_type: 'image/jpeg')
    "created a dog for Owner #{owner.id}"
    dogs << dog
  end
end

puts "Created #{dogs.length} dogs"

puts "Seed data created successfully!"
