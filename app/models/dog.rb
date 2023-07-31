class Dog < ApplicationRecord
  include ImageUrlConcern

  belongs_to :owner
  belongs_to :breed
  has_many :from_matches, class_name: 'Match', foreign_key: 'from_owner_id'
  has_many :to_matches, class_name: 'Match', foreign_key: 'to_owner_id'
  has_many_attached :images

end
