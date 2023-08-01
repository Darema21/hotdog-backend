class Api::V1::MatchShowSerializer < ActiveModel::Serializer
  attributes :id, :message, :owner_id, :match_id

  def owner
    {
      name: object.name
    }
  end


end
