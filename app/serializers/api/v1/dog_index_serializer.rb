class Api::V1::DogIndexSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :gender, :neutered, :vaccinated, :image_urls, :owner_info

  def image_urls
    object.image_urls
  end

  def owner_info
    {
      id: object.owner.id,
      image_url: object.owner.image_url
    }
  end
end
