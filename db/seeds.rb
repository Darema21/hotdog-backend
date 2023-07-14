require 'json'
require 'open-uri'

# Breed descriptions
breed_descriptions = {
  "Beagle" => "The Beagle is a small to medium-sized dog breed known for its distinctive appearance and keen sense of smell. With its short, sleek coat and droopy ears, the Beagle is an adorable and friendly companion. They are often characterized by their playful and curious nature, making them great family pets.",
  "Bulldog" => "The Bulldog, also known as the English Bulldog, is a sturdy and muscular dog breed with a distinctive wrinkled face and a determined expression. Despite their tough appearance, Bulldogs are known for their gentle and affectionate nature, making them excellent family pets. They are generally calm and docile, preferring a relaxed lifestyle over vigorous exercise.",
  "Chihuahua" => "The Chihuahua is a tiny and lively dog breed known for its sassy personality and big personality. These pint-sized canines are often characterized by their large, round eyes and delicate features. Chihuahuas are highly devoted to their owners and thrive on companionship. Despite their small size, they are often fearless and confident, sometimes even displaying a bit of an attitude.",
  "Corgi" => "The Corgi, specifically the Pembroke Welsh Corgi, is a small herding dog breed that is known for its adorable appearance and lively personality. They have a distinct body structure with short legs and a long torso. Corgis are highly intelligent and eager to please, making them easy to train. They are often energetic and playful, enjoying activities such as fetch and agility training.",
  "French Bulldog" => "The French Bulldog, or Frenchie, is a small and compact dog breed with a unique appearance and a charming personality. With their bat-like ears and expressive eyes, French Bulldogs are instantly recognizable. They have a friendly and affectionate disposition and are known for being great companions. Despite their small size, French Bulldogs have a sturdy build and a playful nature.",
  "German Shepherd" => "The German Shepherd is a large and noble dog breed renowned for its intelligence, loyalty, and versatility. These dogs are highly trainable and often serve in various roles such as police dogs, search and rescue dogs, and guide dogs. German Shepherds have a strong protective instinct and make excellent guard dogs.",
  "Golden Retriever" => "The Golden Retriever is a friendly and intelligent dog breed that is beloved for its gentle nature and loyalty. With their luxurious golden coat and friendly expression, they are often considered one of the most beautiful and iconic dog breeds. Golden Retrievers are highly adaptable and excel in various roles, including family pets, therapy dogs, and search and rescue dogs.",
  "Husky" => "The Husky is a medium to large-sized working dog breed that is famous for its striking appearance and sled-pulling abilities. Huskies have a dense double coat, erect ears, and captivating blue or multi-colored eyes. They are known for their endurance and agility, making them ideal for activities like sledding and skijoring.",
  "Labrador" => "The Labrador Retriever, often referred to as Lab, is a popular and versatile dog breed known for its friendly nature, intelligence, and loyalty. Labs have a sturdy and athletic build, making them excellent companions for outdoor activities and sports. They are highly trainable and often serve as service dogs, therapy dogs, and search and rescue dogs.",
  "Pug" => "The Pug is a small dog breed known for its distinctive appearance, with a wrinkled face, a curly tail, and large, expressive eyes. Pugs have a charming and mischievous personality, making them excellent companions for families and individuals. They have a friendly and affectionate nature, often seeking attention and close contact with their owners.",
  "Toy Poodle" => "The Toy Poodle is a small and elegant dog breed known for its intelligence, agility, and delightful personality. With their curly and dense coat, they are often considered one of the most hypoallergenic dog breeds. Toy Poodles are highly trainable and excel in activities such as obedience, agility, and even therapy work."
}

# Creating breeds
base_url = "https://api.api-ninjas.com/v1/dogs?name="
breed_names = ["Beagle", "Bulldog", "Chihuahua", "Corgi", "French Bulldog", "German Shepherd", "Golden Retriever", "Husky", "Labrador", "Parson Russell Terrier", "Pug", "Toy Poodle"]
api_key = { 'X-Api-Key' => 'Cqi1z+e5/4SUPNJX4yz3gA==RnQVVVLkceE3dqQC' }

breed_names.each do |breed_name|
  url = "#{base_url}#{breed_name}"
  puts "Seeding #{breed_name}"
  response = URI.open(url, api_key).read
  breed_data_array = JSON.parse(response)

  next if breed_data_array.nil? || breed_data_array.empty?

  if breed_name.downcase == "bulldog"
    breed_data_array.each do |breed_data|
      breed = Breed.create(
        name: breed_data['name'],
        description: breed_descriptions[breed_data['name']],
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
        min_weight_female: breed_data['min_weight_female'],
        photo: ''
      )

      file_path = Rails.root.join('app', 'assets', 'images', 'breeds', "#{breed_data['name'].downcase}.png")
      breed.update(photo: "path/to/local/image.png") if File.exist?(file_path)
    end
  else
    breed_data = breed_data_array.first

    breed = Breed.create(
      name: breed_data['name'],
      description: breed_descriptions[breed_data['name']],
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
      min_weight_female: breed_data['min_weight_female'],
      photo: ''
    )

    file_path = Rails.root.join('app', 'assets', 'images', 'breeds', "#{breed_data['name'].downcase}.png")
    breed.update(photo: "path/to/local/image.png") if File.exist?(file_path)
  end
end
