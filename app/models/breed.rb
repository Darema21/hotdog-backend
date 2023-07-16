class Breed < ApplicationRecord
  has_one_attached :image

  # def image_url
  #   Rails.application.routes.url_helpers.rails_blob_url(image) if image.attached?
  # end

  # def image_url
  #   if image.attached?
  #     Cloudinary::Utils.cloudinary_url(image.key) # Use the Cloudinary URL helper
  #   end
  # end

end
