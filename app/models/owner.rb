class Owner < ApplicationRecord
  has_one :dog
  has_many :from_matches, class_name: 'Match', foreign_key: 'from_owner_id'
  has_many :to_matches, class_name: 'Match', foreign_key: 'to_owner_id'
  has_one_attached :photo

  # validates :name, presence: true, length: { minimum: 2}
  # validates :age, presence: true
  # validates :gender, presence: true
  # validates :bio, presence: true, length: { minimum: 5}
  # validates :active, presence: true
end

# need to check if need to validate wechat_id and if active as boolean should be mandatory or not
