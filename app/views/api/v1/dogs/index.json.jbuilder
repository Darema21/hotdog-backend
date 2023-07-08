json.array! @dogs do |dog|
  json.partial! 'api/v1/dogs/dog', { dog: dog}
end
