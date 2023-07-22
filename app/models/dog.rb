class Dog < ApplicationRecord
  belongs_to :owner
  belongs_to :breed
  has_many_attached :images

  # validates :name, presence: true, length: { minimum: 2 }
  # validates :gender, presence: true
  # validates :age, presence: true
  # validates :neutered, presence: true
  # validates :vaccinated, presence: true
  # validates :bio, presence: true, length: { minimum: 5 }
  # validates :address, presence: true

  def image_urls
    if images.attached?
      images.map do |image|
        Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
      end
    end
  end
end
