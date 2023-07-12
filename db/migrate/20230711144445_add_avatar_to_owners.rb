class AddAvatarToOwners < ActiveRecord::Migration[7.0]
  def change
    add_column :owners, :avatar, :string
  end
end
