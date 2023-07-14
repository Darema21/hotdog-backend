class Api::V1::BreedsController < Api::V1::BaseController

  def index
    @breeds = Breed.all
    render json: @breeds.as_json(only: [:id, :name, :photo])
  end



  def show
    breed = Breed.find(params[:id])
    puts breed.inspect
    render json: breed, serializer: Api::V1::BreedSerializer
  end

end
