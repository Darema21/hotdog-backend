class Api::V1::MatchIndexSerializer < ActiveModel::Serializer
  attributes :id, :matched_owner, :matched_dog, :status, :created_at

  def matched_owner
    if object.from_owner_id == instance_options[:current_owner].id
      # Return to_owner info if current_owner is from_owner
      {
        id: object.to_owner.id,
        name: object.to_owner.name,
        image_url: object.to_owner.image_url,
        active: object.to_owner.active
      }
    elsif object.to_owner_id == instance_options[:current_owner].id
      # Return from_owner info if current_owner is to_owner
      {
        id: object.from_owner.id,
        name: object.from_owner.name,
        image_url: object.from_owner.image_url,
        active: object.from_owner.active
      }
    else
      nil
    end
  end

  def matched_dog
    if object.from_owner_id == instance_options[:current_owner].id
      dog_data(object.to_owner.dog)
    elsif object.to_owner_id == instance_options[:current_owner].id
      dog_data(object.from_owner.dog)
    else
      {}
    end
  end

  def created_at
    object.created_at.strftime('%B %e, %Y')
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
