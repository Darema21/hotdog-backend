class Dog < ApplicationRecord
  belongs_to :owner
  belongs_to :breed
  has_many_attached :images

  validates :name, presence: true, length: { minimum: 2 }
  validates :gender, presence: true
  validates :age, presence: true
  validates :neutered, presence: true
  validates :vaccinated, presence: true
  validates :bio, presence: true, length: { minimum: 5 }
  validates :address, presence: true

  def image_url
    if image.attached?
      Cloudinary::Utils.cloudinary_url(image.key) # Use the Cloudinary URL helper
    end
  end

end
