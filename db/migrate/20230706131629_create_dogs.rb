class CreateDogs < ActiveRecord::Migration[7.0]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :gender
      t.integer :age
      t.boolean :neutered
      t.boolean :vaccinated
      t.string :address
      t.text :bio
      t.references :owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
