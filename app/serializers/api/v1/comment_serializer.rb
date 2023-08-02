class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :message, :match_id, :owner

  def owner
    {
      id: object.owner.id,
      name: object.owner.name
    }
  end


end
