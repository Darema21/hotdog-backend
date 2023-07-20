class Api::V1::BreedSerializer < ActiveModel::Serializer
  include CloudinaryHelper

  attributes :name, :description, :friendliness_index, :maintenance_index, :activity_index, :trainability_index,
             :average_life_expectancy, :average_weight, :average_height, :best_matches, :image_url

  def image_url
    object.image_url
  end

  def friendliness_index
    (object.good_with_children + object.good_with_other_dogs + object.good_with_strangers) / 15.0
  end

  def maintenance_index
    (object.shedding + object.grooming + object.drooling) / 15.0
  end

  def activity_index
    (object.playfulness + object.energy + object.barking) / 15.0
  end

  def trainability_index
    object.trainability / 5.0
  end

  def average_life_expectancy
    (object.max_life_expectancy + object.min_life_expectancy) / 2.0
  end

  def average_weight
    (object.max_weight_male + object.min_weight_male + object.max_weight_female + object.min_weight_female) / 4.0
  end

  def average_height
    (object.max_height_male + object.min_height_male + object.max_height_female + object.min_height_female) / 4.0
  end

  # def best_matches
  #   target_breed = object
  #   target_breed.best_matches.map do |match|
  #     {
  #       breed_name: match[:breed].name,
  #       similarity_score: match[:similarity_score]
  #     }
  #   end

  def best_matches
    all_breeds = Breed.where.not(id: object.id) # Exclude the current breed

    return all_breeds.map do |breed|
      breed_data = breed.as_json
      breed_data['image_url'] = breed_image_url(breed) # Add the image_url to the breed hash
      similarity_score = calculate_similarity_score(breed_data)
      { id: breed.id, name: breed.name, image_url: breed_data['image_url'], similarity_score: similarity_score }
    end.sort_by { |match| -match[:similarity_score] }.take(3)
  end


  def breed_image_url(breed)
    breed_object = Breed.find_by(id: breed['id'])
    breed_object.image_url if breed_object&.image.attached?
  end

  private

  def serial(breed)
    ActiveModelSerializers::SerializableResource.new(breed, serializer: Api::V1::BreedSerializer)
  end

  def calculate_similarity_score(other_breed)
      # puts "----------asdads-----------------"
      # puts object
      # puts other_breed
      # puts serial(other_breed)
      # puts serial(other_breed).as_json
      # puts serial(other_breed).friendliness_index
      # puts "----------asdads-----------------"

      friendliness_diff = ((object.good_with_children + object.good_with_other_dogs + object.good_with_strangers) / 15.0 - (other_breed["good_with_children"] + other_breed["good_with_other_dogs"] + other_breed["good_with_strangers"]) / 15.0).abs / 1.0
      maintenance_diff = ((object.shedding + object.grooming + object.drooling) / 15.0 - (other_breed["shedding"] + other_breed["grooming"] + other_breed["drooling"]) / 15.0).abs / 1.0
      activity_diff = ((object.playfulness + object.energy + object.barking) / 15.0 - (other_breed["playfulness"] + other_breed["energy"] + other_breed["barking"]) / 15.0).abs / 1.0
      trainability_diff = (object.trainability / 5.0 - other_breed["trainability"] / 5.0).abs / 1.0
      life_expectancy_diff = ((object.max_life_expectancy + object.min_life_expectancy) / 2.0 - (other_breed["max_life_expectancy"] + other_breed["min_life_expectancy"]) / 2.0).abs / 10.0
      weight_diff = ((object.max_weight_male + object.min_weight_male + object.max_weight_female + object.min_weight_female) / 4.0 - (other_breed['max_weight_male'] + other_breed["min_weight_male"] + other_breed["max_weight_female"] + other_breed["min_weight_female"]) / 4.0).abs / 100.0

      puts "Friendliness Diff: #{friendliness_diff}"
      puts "Maintenance Diff: #{maintenance_diff}"
      puts "Activity Diff: #{activity_diff}"
      puts "Trainability Diff: #{trainability_diff}"
      puts "Life Expectancy Diff: #{life_expectancy_diff}"
      puts "Weight Diff: #{weight_diff}"

    # height_diff = (object.average_height - other_breed["average_height"]).abs / 1.0

    # similarity_score = 1.0 - (friendliness_diff + maintenance_diff + activity_diff +
    #                           trainability_diff + life_expectancy_diff +
                              # weight_diff + height_diff) / 7.0

       similarity_score = 1.0 - (friendliness_diff + maintenance_diff +
                                activity_diff + trainability_diff +
                                life_expectancy_diff + weight_diff) / 6.0
    # puts "similarity_score"
    similarity_score
  end
end
