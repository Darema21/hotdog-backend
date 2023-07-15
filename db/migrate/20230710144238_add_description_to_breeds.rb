class AddDescriptionToBreeds < ActiveRecord::Migration[7.0]
  def change
    add_column :breeds, :description, :text
  end
end
