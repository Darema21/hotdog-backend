class Owner < ApplicationRecord
  has_one :dog
  # has_many :matches
  has_many :from_matches, class_name: 'Match', foreign_key: 'from_owner_id'
  has_many :to_matches, class_name: 'Match', foreign_key: 'to_owner_id'
  has_one_attached :photo

  has_many :bookings
  has_many :events
  has_many :booked_events, through: :bookings, source: :event
  has_many :recieved_bookings, through: :events, source: :bookings

  def image_url
    if photo.attached?
      photo.url
    end
  end

end

# need to check if need to validate wechat_id and if active as boolean should be mandatory or not
