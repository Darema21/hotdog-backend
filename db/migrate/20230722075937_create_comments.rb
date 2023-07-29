class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :owner
      t.text :message

      t.timestamps
    end
  end
end
