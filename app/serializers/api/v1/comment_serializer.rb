class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :message, :match_id, :owner, :created_at

  def owner
    {
      id: object.owner.id,
      name: object.owner.name
    }
  end

  def created_at
    object.created_at.strftime('%B %e, %Y %H:%M')
  end


end
