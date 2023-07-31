class Breed < ApplicationRecord
  has_one_attached :image

  def image_url
    if image.attached?
      image.url
    end
  end

end
