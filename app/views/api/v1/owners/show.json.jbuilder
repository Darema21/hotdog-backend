json.owner @current_owner
json.matches @matches
json.matched_dogs do

end

#keeping this just in case
# json.matches do
#   json.array! @matches do |match|
#     json.partial! 'ap1/v1/dog', { dog: dog}
#   end
# end
