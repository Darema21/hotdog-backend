class Breed < ApplicationRecord

  validates :name, presence: true

  has_one_attached :images

end
