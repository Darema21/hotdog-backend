class ChangeOwnerToOwnerIdInComments < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :owner, :string
    add_reference :comments, :owner, foreign_key: true
  end
end
