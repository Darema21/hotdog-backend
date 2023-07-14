class Api::V1::BreedSerializer < ActiveModel::Serializer
    attributes :name, :description, :friendliness_index, :maintenance_index, :activity_index, :trainability_index,
               :average_life_expectancy, :average_weight, :average_height, :photo

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
  end
