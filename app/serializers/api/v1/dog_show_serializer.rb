class Api::V1::DogShowSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :gender, :age, :neutered, :vaccinated, :address, :bio, :breed, :owner, :breed, :image_urls

  def image_urls
    object.image_urls
  end

  def owner
    {
      id: object.owner.id,
      name: object.owner.name,
      age: object.owner.age,
      gender: object.owner.gender,
      bio: object.owner.bio,
      wechat_id: object.owner.wechat_id,
      image_url: object.owner.image_url,
      active: object.owner.active
    }
  end

  def breed
    {
      id: object.breed.id,
      name: object.breed.name
    }
  end


end
