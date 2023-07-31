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

Match.destroy_all
Booking.destroy_all
Dog.destroy_all
Breed.destroy_all
Event.destroy_all
Owner.destroy_all

# # Breed descriptionss
breed_data = [
  {name: 'Afghan Hound', image: 'app/assets/images/breeds/afghan_hound.png', description: 'The Afghan Hound is a regal and elegant dog breed known for its long, flowing coat and graceful appearance. Originally bred for hunting in the mountainous regions of Afghanistan, these dogs have a keen sense of sight and speed. Afghan Hounds are independent and somewhat aloof, but they can form strong bonds with their owners. They are often characterized by their aristocratic demeanor and dignified nature.'}
  { name: 'Beagle', image: 'app/assets/images/breeds/beagle.png', description: 'The Beagle is a small to medium-sized dog breed known for its distinctive appearance and keen sense of smell. With its short, sleek coat and droopy ears, the Beagle is an adorable and friendly companion. They are often characterized by their playful and curious nature, making them great family pets.' },
  { name: 'Border Collie', image: 'app/assets/images/breeds/border_collie.png', description: 'The Border Collie is a highly intelligent and energetic dog breed known for its herding instincts and trainability. These dogs are often considered one of the most intelligent dog breeds and excel in various canine sports and activities. Border Collies are diligent and hardworking, making them excellent working dogs on farms or in various canine sports and activities.' },
  { name: 'Bulldog', image: 'app/assets/images/breeds/american_bulldog.png', description: 'The Bulldog, also known as the English Bulldog, is a sturdy and muscular dog breed with a distinctive wrinkled face and a determined expression. Despite their tough appearance, Bulldogs are known for their gentle and affectionate nature, making them excellent family pets. They are generally calm and docile, preferring a relaxed lifestyle over vigorous exercise.' },
  { name: 'Chihuahua', image: 'app/assets/images/breeds/chihuahua.png', description: 'The Chihuahua is a tiny and lively dog breed known for its sassy personality and big personality. These pint-sized canines are often characterized by their large, round eyes and delicate features. Chihuahuas are highly devoted to their owners and thrive on companionship. Despite their small size, they are often fearless and confident, sometimes even displaying a bit of an attitude.' },
  { name: 'Chow Chow', image: 'app/assets/images/breeds/chow_chow.png', description: 'The Chow Chow is a distinctive and ancient dog breed known for its lion-like mane and unique blue-black tongue. With its dignified and aloof nature, Chow Chows can be reserved around strangers but are loyal and devoted to their family members. They are independent and may require consistent training and socialization from a young age.' },
  { name: 'Corgi', image: 'app/assets/images/breeds/corgi.png', description: 'The Corgi, specifically the Pembroke Welsh Corgi, is a small herding dog breed that is known for its adorable appearance and lively personality. They have a distinct body structure with short legs and a long torso. Corgis are highly intelligent and eager to please, making them easy to train. They are often energetic and playful, enjoying activities such as fetch and agility training.' },
  { name: 'Dachshund', image: 'app/assets/images/breeds/dachshund.png', description: 'The Dachshund, also known as the Wiener Dog or Sausage Dog, is a small and elongated dog breed with a unique body shape. Dachshunds were originally bred for hunting badgers, and they have a fearless and determined nature. They are affectionate and often form strong bonds with their owners, but they can also be stubborn at times. Dachshunds come in various coat types and colors.' },
  { name: 'Dalmatian', image: 'app/assets/images/breeds/dalmatian.png', description: 'The Dalmatian is a distinctive and easily recognizable dog breed known for its white coat with black spots. Dalmatians have a playful and outgoing personality, making them great family pets and companions. They are often associated with firefighters and firehouses due to their historical role as carriage dogs and firehouse mascots. Dalmatians are energetic and require regular exercise and mental stimulation.' },
  { name: 'French Bulldog', image: 'app/assets/images/breeds/french_bulldog.png', description: 'The French Bulldog, or Frenchie, is a small and compact dog breed with a unique appearance and a charming personality. With their bat-like ears and expressive eyes, French Bulldogs are instantly recognizable. They have a friendly and affectionate disposition and are known for being great companions. Despite their small size, French Bulldogs have a sturdy build and a playful nature.' },
  { name: 'German Shepherd', image: 'app/assets/images/breeds/german_shepherd.png', description: 'The German Shepherd is a large and noble dog breed renowned for its intelligence, loyalty, and versatility. These dogs are highly trainable and often serve in various roles such as police dogs, search and rescue dogs, and guide dogs. German Shepherds have a strong protective instinct and make excellent guard dogs.' },
  { name: 'Golden Retriever', image: 'app/assets/images/breeds/golden_retriever.png', description: 'The Golden Retriever is a friendly and intelligent dog breed that is beloved for its gentle nature and loyalty. With their luxurious golden coat and friendly expression, they are often considered one of the most beautiful and iconic dog breeds. Golden Retrievers are highly adaptable and excel in various roles, including family pets, therapy dogs, and search and rescue dogs.' },
  { name: 'Husky', image: 'app/assets/images/breeds/husky.png', description: 'The Husky is a medium to large-sized working dog breed that is famous for its striking appearance and sled-pulling abilities. Huskies have a dense double coat, erect ears, and captivating blue or multi-colored eyes. They are known for their endurance and agility, making them ideal for activities like sledding and skijoring.' },
  { name: 'Labrador', image: 'app/assets/images/breeds/labrador.png', description: 'The Labrador Retriever, often referred to as Lab, is a popular and versatile dog breed known for its friendly nature, intelligence, and loyalty. Labs have a sturdy and athletic build, making them excellent companions for outdoor activities and sports. They are highly trainable and often serve as service dogs, therapy dogs, and search and rescue dogs.' },
  { name: 'Parson Russell Terrier', image: 'app/assets/images/breeds/parson_russell_terrier.png', description: 'The Parson Russell Terrier is a small, energetic, and intelligent breed. With its compact, muscular body and lively expression, it is an attractive and charming dog. Known for its alertness and attentiveness, the Parson Russell Terrier is always ready to explore and investigate its surroundings. It has a distinctive wiry coat that comes in various colors, such as white, white with tan or black markings, or tricolor. This breed is highly active and requires regular exercise to stay happy and healthy.' },
  { name: 'Pug', image: 'app/assets/images/breeds/pug.png', description: 'The Pug is a small dog breed known for its distinctive appearance, with a wrinkled face, a curly tail, and large, expressive eyes. Pugs have a charming and mischievous personality, making them excellent companions for families and individuals. They have a friendly and affectionate nature, often seeking attention and close contact with their owners.' },
  { name: 'Poodle (Toy)', image: 'app/assets/images/breeds/toy_poodle.png', description: 'The Toy Poodle is a small and elegant dog breed known for its intelligence, agility, and delightful personality. With their curly and dense coat, they are often considered one of the most hypoallergenic dog breeds. Toy Poodles are highly trainable and excel in activities such as obedience, agility, and even therapy work.' },
  { name: 'Samoyed', image: 'app/assets/images/breeds/samoyed.png', description: 'The Samoyed is a fluffy and friendly dog breed known for its smiley face and thick, white coat. Originally bred to work as herding and sledding dogs in Siberia, Samoyeds are known for their gentle and affectionate nature. They are sociable and get along well with children and other pets. Samoyeds are intelligent and may benefit from training and activities that keep them mentally stimulated.' }
]


# # # # Creating breeds
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
    # response = URI.open(url,'X-Api-Key'=>api_key ).read
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

# # # dog_url = "https://api.unsplash.com/search/photos?query=dog&client_id=vxJlLu9p1P2BcV2Aqq0DgLT1owhw_O14_qtCH461gnE"
# # # owner_url = "https://api.unsplash.com/search/photos?query=person&client_id=vxJlLu9p1P2BcV2Aqq0DgLT1owhw_O14_qtCH461gnE"

# # # Function to download an image from the given URL
# # # def download_image(url)
# # #   open(url) { |image| image.read }
# # # end

# # # URLs for specific dog and owner images
dog_image_urls = [
  "https://images.unsplash.com/photo-1518374835801-2c7d993de05c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80",
  "https://images.unsplash.com/photo-1583511655802-41f2ccc2cc8f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTQxfHxkb2d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1562714529-94d65989df68?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTI2fHxkb2d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1612940960267-4549a58fb257?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTE3fHxkb2d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1572566830488-069bcc7fbcec?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTE1fHxkb2d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1618173745201-8e3bf8978acc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTEwfHxkb2d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1588269864631-ced7dff8da0d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OTN8fGRvZ3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1534351450181-ea9f78427fe8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTAyfHxkb2d8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1598133894008-61f7fdb8cc3a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=688&q=80",
  "https://images.unsplash.com/photo-1535930891776-0c2dfb7fda1a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1074&q=80",
  "https://images.unsplash.com/photo-1518378188025-22bd89516ee2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80",
  "https://images.unsplash.com/photo-1520721973443-8f2bfd949b19?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDR8fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1488290518759-5747f87b653f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDd8fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1453227588063-bb302b62f50b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDl8fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1529343097104-386dca989049?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDEyfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1595301209932-587938108299?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDEzfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1578161467910-11ca4025aa0e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDExfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1613210587443-348d07e782c5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE5fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1613051466655-682343e2f2dd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MXw1MDM1NDM2fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1551308075-d5f542da6386?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8NXw1MDM1NDM2fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1604186838347-9faaf0b83be8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8NHw1MDM1NDM2fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1544175089-f2e93cb8b8c5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MTB8NTAzNTQzNnx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1583885538780-dc9ae1176b90?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MTZ8NTAzNTQzNnx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1579527851415-381673d82a51?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MTV8NTAzNTQzNnx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1553499057-2e1b15f16f8c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MjB8NTAzNTQzNnx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1567607593745-ad0fa4cde919?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MjJ8NTAzNTQzNnx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1535311310-78aa1fc96804?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MzJ8NTAzNTQzNnx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1562244510-70270c6e138f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8Mzd8NTAzNTQzNnx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1447768005573-3b54cdf058a2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8NDV8NTAzNTQzNnx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1561438774-1790fe271b8f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8NTV8NTAzNTQzNnx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60"
]

owner_image_urls = [
  "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1748&q=80",
  "https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTExfHxwZXJzb258ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1589696485114-9e2f81d83484?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTIyfHxwZXJzb258ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1549068106-b024baf5062d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTA0fHxwZXJzb258ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1530268729831-4b0b9e170218?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OTl8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1525875975471-999f65706a10?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OTR8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1506863530036-1efeddceb993?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8ODl8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1615813967515-e1838c1c5116?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTN8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60",
  "https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80",
  "https://images.unsplash.com/photo-1519058082700-08a0b56da9b4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80"
]

# Create owners
puts "Creating Owners"
owners = []

10.times do |i|
  owner_photo_file = URI.open(owner_image_urls[i]) # Get the photo for this owner from the owner_image_urls array

  owner = Owner.create(
    name: Faker::Name.name,
    age: Faker::Number.between(from: 18, to: 65),
    gender: Faker::Gender.binary_type,
    bio: Faker::Lorem.paragraph,
    wechat_id: Faker::Alphanumeric.alphanumeric(number: 6),
    active: true
  )

  # Attach owner photo using the specified URL
  owner.photo.attach(io: owner_photo_file, filename: "#{owner.name.parameterize}_owner.jpg", content_type: 'image/jpg')

  puts "add photos"
  puts i

  owners << owner
end

# puts "Created #{owners.length} owners"

# Create dogs and assign each dog to a unique owner
puts "Creating Dogs"
breeds = Breed.all

dogs = []
owners = Owner.all
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
    dog_photo_file = URI.open(dog_image_urls.sample)
    dog.images.attach(io: dog_photo_file, filename: "#{dog.name.parameterize}_dog.jpg", content_type: 'image/jpeg')
    "created a dog for Owner #{owner.id}"
    dogs << dog
  end
end

puts "Created #{dogs.length} dogs"

puts "Seed data created successfully!"

# Find the owner with to_owner_id = 2
to_owner = Owner.second
dogs  = Dog.all

# Create matches
puts "Creating Matches"
matches = []

dogs.each do |dog|
match = Match.create(
     status: "undecided",
     from_owner_id: dog.owner.id,
     to_owner_id: to_owner.id,
     from_owner_decision: "right"
   )

   matches << match
 end


# Create Events and Bookings
puts 'Creating Events and Bookings'

custom_titles = [
  "Playtime in the Park",
  "Puppy Playdate",
  "Cat Cuddle Session",
  "Adopt-a-thon",
  "Dog Training Workshop",
  "Pet Photo Contest",
  "Kitten Adoption Fair",
  "Pet Wellness Seminar",
  "Pet Fashion Show",
  "Furry Friends Meetup"
]

custom_descriptions = [
  "Join us for a fun-filled day at the park, where your pets can enjoy playtime with other furry friends.",
  "Bring your puppies for a playful and socializing experience. Meet other puppy owners and let your pups have a blast.",
  "Calling all cat lovers! Spend quality time cuddling and bonding with adorable cats in a relaxed setting.",
  "Find your new furry companion at our adopt-a-thon event. Give a forever home to a shelter pet in need.",
  "Learn effective training techniques for your dogs from expert trainers. Improve your pet's behavior and obedience.",
  "Capture the best moments of your beloved pets and stand a chance to win exciting prizes in our pet photo contest.",
  "Discover a wide variety of adorable kittens available for adoption. Give a loving home to a cute little friend.",
  "Take charge of your pet's health and well-being. Join our informative seminar on pet wellness and care.",
  "Watch adorable pets strut their stuff in our pet fashion show. Enjoy the cuteness overload!",
  "Meet fellow pet owners and their furry friends. Make new connections and let your pets socialize."
]

event_image_urls = [
  "https://img.freepik.com/free-vector/organic-birthday-background_52683-58494.jpg?w=996&t=st=1690786618~exp=1690787218~hmac=95b3028100d1fe848a70d12df3db750dd88aeecd25437c84a6bdc00e4725eaca",
  "https://img.freepik.com/free-vector/editable-party-banner-template-remixed-from-artworks-by-moriz-jung_53876-117447.jpg?w=1380&t=st=1690786697~exp=1690787297~hmac=f665d8f6a214c3d347a6227b2487fab349dca903f2ae1f1f428ea3d7738a69e2",
  "https://img.freepik.com/free-vector/smiling-hamster-birthday-background_23-2148032462.jpg?w=826&t=st=1690786726~exp=1690787326~hmac=0fbc37ea7d66bec1b963a37746dc5b1df5fb08822cbd73f7d228d40be16824cb",
  "https://img.freepik.com/free-photo/adorable-dog-with-abstract-colorful-graphic-background_23-2150022291.jpg?w=1380&t=st=1690786740~exp=1690787340~hmac=52ed6aaa94a014e9213819b4fc6945432a8de6c806ba063b21aa7fd681cfdf38",
  "https://img.freepik.com/free-vector/flat-design-birthday-background_23-2148605727.jpg?w=1380&t=st=1690786761~exp=1690787361~hmac=00db95cd79af341b888e322f7acfce3212604fe46978d2f8f8a3fe1d20c28ec5",
  "https://img.freepik.com/free-vector/happy-birthday-holiday-baby-shower-celebration-greeting-invitation-card_60438-1373.jpg?w=1800&t=st=1690786796~exp=1690787396~hmac=613a881100c5eefc645636c6b245355aa24348d7124347338759fedbf606f2b8",
  "https://img.freepik.com/free-photo/cute-dog-treated-with-delicious-cupcake_23-2148326227.jpg?w=1060&t=st=1690786829~exp=1690787429~hmac=02e67b7f85aad1f1bd934df185be452f35b1acc727582118f1ab9580e01ee07e",
  "https://img.freepik.com/free-vector/flat-national-dog-day-illustration_23-2148996158.jpg?w=826&t=st=1690786860~exp=1690787460~hmac=1f84aabc4801d027f2aa98d55ae6fd9e5f29e1819ac3343fddca11837719b19f",
  "https://img.freepik.com/free-vector/party-invitation-with-nice-hen-fox_23-2147587215.jpg?w=826&t=st=1690786891~exp=1690787491~hmac=b9af0f84e7b27b2d7c850ad9e6211f6e2d5b2639647f20085b9fb7bbe889910d",
  "https://img.freepik.com/free-vector/flat-design-dog-pool-party-illustration_23-2150506802.jpg?w=826&t=st=1690786957~exp=1690787557~hmac=04f01f4789a2adfa0e97c5449871f452a2d5e1c2fd59194ab0b444f9eebdd6ee"
]

categories = ['food', 'music', 'sports', 'nightlife', 'art']
owners = Owner.all

10.times do
  category = categories.sample
  start_time = Faker::Time.forward(days: 15, period: :evening, format: :long)

  title = custom_titles.pop
  description = custom_descriptions.pop

  owner = owners.sample # Randomly select an owner for the event

  event = Event.new(
    title: title,
    description: description,
    start_time: start_time,
    address: Faker::Address.full_address,
    owner: owner, # Assign the selected owner to the event
    category: category
  )

  if event.save
    booking = Booking.create(owner: owner, event: event)
    if booking.save
      puts "Event '#{event.id}' created successfully by owner '#{owner.id}', and booking created for owner '#{owner.id}'"
    else
      puts "Error creating booking: #{booking.errors.full_messages.join(', ')}"
    end
  else
    puts "Error creating event: #{event.errors.full_messages.join(', ')}"
  end
end
