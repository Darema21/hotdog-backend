class Api::V1::MatchSerializer < ActiveModel::Serializer
  attributes :from_owner_id, :to_owner_id, :from_owner, :to_owner, :from_dog, :to_dog, :status

  def from_owner
    {
      id: object.from_owner.id,
      image_url: object.from_owner.image_url,
      active: object.from_owner.active
    }
  end

  def to_owner
    {
      id: object.to_owner.id,
      image_url: object.to_owner.image_url,
      active: object.to_owner.active
    }
  end

  def from_dog
    dog = object.from_owner.dog
    dog_data(dog)
  end

  def to_dog
    dog = object.to_owner.dog
    dog_data(dog)
  end

  private

  def dog_data(dog)
    {
      id: dog.id,
      name: dog.name,
      image_url: dog.image_urls&.first
    }
  end
end
