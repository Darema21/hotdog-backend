class Api::V1::DogIndexSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :gender, :neutered, :vaccinated, :image_urls, :owner_id

  def image_urls
    object.image_urls
  end

  def owner_id
    object.owner.id
  end

end
