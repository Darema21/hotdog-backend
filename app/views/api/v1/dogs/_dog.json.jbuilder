json.extract! dog, :id, :name, :gender, :age, :neutered, :vaccinated, :bio, :address
if images.attached?
  json.images do
    dog.images.each do |image|
      json.image_url url_for(image)
    end
end
