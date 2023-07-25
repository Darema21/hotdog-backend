class Match < ApplicationRecord
  belongs_to :from_owner, class_name: 'Owner', foreign_key: 'from_owner_id'
  belongs_to :to_owner, class_name: 'Owner', foreign_key: 'to_owner_id'
  # belongs_to :from_dog, through: :from_owner, source: :dog
  # belongs_to :to_dog, through: :to_owner, source: :dog

  validates :from_owner_id, uniqueness: { scope: :to_owner_id, message: 'You can only have one match with the same owner.' }
end
