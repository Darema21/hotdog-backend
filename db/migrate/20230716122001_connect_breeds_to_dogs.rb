# db/migrate/20230717123456_connect_breeds_to_dogs.rb

class ConnectBreedsToDogs < ActiveRecord::Migration[7.0]
  def change
    add_reference :dogs, :breed, foreign_key: true
  end
end
