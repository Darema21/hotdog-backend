class Dog < ApplicationRecord
  belongs_to :owner

  validates: name, presence: true, length: { minimum: 2}
  validates: gender, presence: true
  validates: age, presence: true
  validates: neutered, presence: true #need to double check on presence, this is boolean
  validates: vaccinated, presence: true #also boolean
  validates: bio, presence: true, , length: { minimum: 5}
  validates: address
  validates: gender, presence: true
end

#we also need to add photo later
