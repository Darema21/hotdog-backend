class AddDefaultToActiveStatus < ActiveRecord::Migration[7.0]
  def change
    change_column :owners, :active, :boolean, :default => true
  end
end
