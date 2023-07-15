class Api::V1::DogSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :age, :neutered, :vaccinated, :address, :bio, :breed, :owner

  def owner
    {
      id: object.owner.id,
      name: object.owner.name,
      age: object.owner.age,
      gender: object.owner.gender,
      bio: object.owner.bio,
      wechat_id: object.owner.wecchat_id,
      active: object.owner.active,

    }
  end

end
