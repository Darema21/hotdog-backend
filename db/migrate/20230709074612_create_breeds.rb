class CreateBreeds < ActiveRecord::Migration[7.0]
  def change
    create_table :breeds do |t|
      t.string :name
      t.integer :good_with_children
      t.integer :good_with_other_dogs
      t.integer :shedding
      t.integer :grooming
      t.integer :drooling
      t.integer :coat_length
      t.integer :good_with_strangers
      t.integer :playfulness
      t.integer :protectiveness
      t.integer :trainability
      t.integer :energy
      t.integer :barking
      t.integer :min_life_expectancy
      t.integer :max_life_expectancy
      t.integer :max_height_male
      t.integer :max_height_female
      t.integer :max_weight_male
      t.integer :max_weight_female
      t.integer :min_height_male
      t.integer :min_height_female
      t.integer :min_weight_male
      t.integer :min_weight_female

      t.timestamps
    end
  end
end
