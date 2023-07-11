class Api::V1::BreedSerializer < ActiveModel::Serializer
  attributes :id, :name, :good_with_children, :good_with_other_dogs, :shedding, :grooming, :drooling,
             :coat_length, :good_with_strangers, :playfulness, :protectiveness, :trainability,
             :energy, :barking, :min_life_expectancy, :max_life_expectancy, :max_height_male,
             :max_height_female, :max_weight_male, :max_weight_female, :min_height_male,
             :min_height_female, :min_weight_male, :min_weight_female, :friendliness_score

             def friendliness_score
              (object.good_with_children + object.good_with_other_dogs + object.good_with_strangers) / 15.0
            end


end
