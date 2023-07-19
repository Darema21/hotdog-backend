class RemoveBreedFromDogs < ActiveRecord::Migration[7.0]
  def change
    remove_column :dogs, :breed, :string
  end
end
