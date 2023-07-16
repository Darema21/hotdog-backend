class Api::V1::BreedsController < Api::V1::BaseController

  def index
    @breeds = Breed.includes(images_attachments: :blob).all
    render json: @breeds.as_json(only: [:id, :name, :images_attachments])
  end


  def show
    breed = Breed.find(params[:id])
    puts breed.inspect
    render json: breed, serializer: Api::V1::BreedSerializer
  end

  def upload_image
    @dog = Breed.find(params[:id])
    @dog.images.attach(params[:images])
  end

end
