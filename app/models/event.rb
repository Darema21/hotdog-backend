class Event < ApplicationRecord
  belongs_to :owner
  has_many :bookings, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :start_time, presence: true
  validates :address, presence: true
  # validates :image, presence: true # to upload event posters
  # validates :user_id, presence: true
  serialize :category
end
