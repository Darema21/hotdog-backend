json.extract! @comment, :id, :message, :owner_id

json.owner do
  json.id @comment.owner.id
  json.name @comment.owner.name
end
