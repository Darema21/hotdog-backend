class Api::V1::BreedSerializer < ActiveModel::Serializer
  attributes :name, :description, :friendliness_index, :maintenance_index, :activity_index, :trainability_index,
             :average_life_expectancy, :average_weight, :average_height, :best_matches


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

  def best_matches
    all_breeds = Breed.where.not(id: object.id) # Exclude the current breed

    return all_breeds.map do |breed|
      breed = breed.as_json
      similarity_score = calculate_similarity_score(breed)
      { breed: breed, similarity_score: similarity_score }
    end.sort_by { |match| -match[:similarity_score] }.take(3)

  end

  private

  def serial(breed)
    ActiveModelSerializers::SerializableResource.new(breed, serializer: Api::V1::BreedSerializer)
  end

  def calculate_similarity_score(other_breed)
    puts "----------asdads-----------------"
    puts object
    puts other_breed
    puts serial(other_breed)
    puts serial(other_breed).as_json
    puts serial(other_breed).friendliness_index
    puts "----------asdads-----------------"

    friendliness_diff = ((object.good_with_children + object.good_with_other_dogs + object.good_with_strangers) / 15.0 - (other_breed["good_with_children"] + other_breed["good_with_other_dogs"] + other_breed["good_with_strangers"]) / 15.0).abs / 1.0
    # maintenance_diff = ((object.shedding + object.grooming + object.drooling) / 15.0 - (other_breed["shedding"] + other_breed["grooming"] + other_breed["drooling"]) / 15.0).abs / 1.0
    # activity_diff = ((object.playfulness + object.energy + object.barking) / 15.0 - (other_breed["playfulness"] + other_breed["energy"] + other_breed["barking"]) / 15.0).abs / 1.0
    # trainability_diff = (object.trainability / 5.0 - other_breed["trainability"] / 5.0).abs / 1.0
    # life_expectancy_diff = ((object.max_life_expectancy + object.min_life_expectancy) / 2.0 - (other_breed["max_life_expectancy"] + other_breed["min_life_expectancy"]) / 2.0).abs / 1.0
    # weight_diff = ((object.max_weight_male + object.min_weight_male + object.max_weight_female + object.min_weight_female) / 4.0 - (other_breed["max_weight_male"] + other_breed["min_weight_male"] + other_breed["max_weight_female"] + other_breed["min_weight_female"]) / 4.0).abs / 1.0
    # height_diff = (object.average_height - other_breed["average_height"]).abs / 1.0


    # similarity_score = 1.0 - (friendliness_diff + maintenance_diff + activity_diff +
    #                          trainability_diff + life_expectancy_diff +
    #                          weight_diff + height_diff) / 7.0
    puts "friendliness_diff"
    friendliness_diff
  end
end
