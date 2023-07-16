class Breed < ApplicationRecord
  has_one_attached :image

  def image_url
    Rails.application.routes.url_helpers.rails_blob_url(image) if image.attached?
  end

  # def photo_url
  #   if photo.attached?
  #     Rails.application.routes.url_helpers.rails_blob_url(photo)
  #   else
  #     # Default placeholder image URL or any other logic you prefer
  #     'https://example.com/placeholder.jpg'
  #   end
  # end
end
