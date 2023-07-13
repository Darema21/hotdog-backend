class Dog < ApplicationRecord
  belongs_to :owner
  has_many_attached :images

  validates :name, presence: true, length: { minimum: 2}
  validates :gender, presence: true
  validates :age, presence: true
  validates :neutered, presence: true
  validates :vaccinated, presence: true
  validates :bio, presence: true, length: { minimum: 5}
  # validates :address, presence: true
end

#we also need to add image later
