class RemovePhotoFromBreed < ActiveRecord::Migration[7.0]
  def change
    remove_column :breeds, :photo, :string
  end
end
