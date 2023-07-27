class AddReferencesToBooking < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :event, null: false, foreign_key: true
    add_reference :bookings, :owner, null: false, foreign_key: true
  end
end
