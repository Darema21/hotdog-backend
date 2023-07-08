class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.string :status
      t.references :from_owner, foreign_key: { to_table: :owners }, null: false
      t.references :to_owner, foreign_key: { to_table: :owners }, null: false
      t.string :from_owner_decision
      t.string :to_owner_decision

      t.timestamps
    end
  end
end
