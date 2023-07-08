json.dogs do
  json.array! @dogs do |dog|
    json.extract! dog, :id, :name, :gender, :age, :neutered, :vaccinated, :bio, :address, :images
  end
end
