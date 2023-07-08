class AddDefaultMatchStatus < ActiveRecord::Migration[7.0]
  def change
    change_column :matches, :status, :string, :default => "undecided"
  end
end
