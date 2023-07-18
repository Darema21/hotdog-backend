module CloudinaryHelper

  def image_url
    if image.attached?
      Cloudinary::Utils.cloudinary_url(image.key) # Use the Cloudinary URL helper
    end
  end

end
