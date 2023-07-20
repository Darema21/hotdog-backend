class Dog < ApplicationRecord
  belongs_to :owner
  belongs_to :breed
  has_many_attached :images

<<<<<<< HEAD
  validates :name, presence: true, length: { minimum: 2}
=======
  validates :name, presence: true, length: { minimum: 2 }
>>>>>>> a4dfaf84b5a37fa2a49e3379d57da0d5a0aaf1ed
  validates :gender, presence: true
  validates :age, presence: true
  validates :neutered, presence: true
  validates :vaccinated, presence: true
<<<<<<< HEAD
  validates :bio, presence: true, length: { minimum: 5}
  # validates :address, presence: true
end
=======
  validates :bio, presence: true, length: { minimum: 5 }
  validates :address, presence: true
>>>>>>> a4dfaf84b5a37fa2a49e3379d57da0d5a0aaf1ed

  def image_urls
    if images.attached?
      images.map do |image|
        Cloudinary::Utils.cloudinary_url(image.key) # Use the Cloudinary URL helper
      end
    end
  end
end
