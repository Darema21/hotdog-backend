class AddMatchRefToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :match, null: false, foreign_key: true
  end
end
