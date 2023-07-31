module ImageUrlConcern
  extend ActiveSupport::Concern

  def image_url
    photo.attached? ? photo.url : nil
  end

  def image_urls
    if images.attached?
      images.map do |image|
        image.url
      end
    end
  end
end
