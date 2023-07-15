class AddOpenIdToOwner < ActiveRecord::Migration[7.0]
  def change
    add_column :owners, :open_id, :string
  end
end
