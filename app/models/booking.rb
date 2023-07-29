class Booking < ApplicationRecord
  belongs_to :owner
  belongs_to :event

  validates :owner_id, uniqueness: { scope: :event_id, message: 'Has already booked this event' }
end
