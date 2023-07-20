class AddPhotoToBreeds < ActiveRecord::Migration[7.0]
  def change
    add_column :breeds, :photo, :string
  end
end
