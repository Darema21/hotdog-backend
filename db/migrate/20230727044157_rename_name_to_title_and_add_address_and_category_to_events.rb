class RenameNameToTitleAndAddAddressAndCategoryToEvents < ActiveRecord::Migration[7.0]
  def change
    rename_column :events, :name, :title
    add_column :events, :address, :string
    add_column :events, :category, :string
  end
end
