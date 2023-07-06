class CreateOwners < ActiveRecord::Migration[7.0]
  def change
    create_table :owners do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.text :bio
      t.string :wechat_id
      t.boolean :active

      t.timestamps
    end
  end
end
