class Api::V1::BreedsController < Api::V1::BaseController

  def index
    @breeds = Breed.includes(image_attachment: :blob).all
    render json: @breeds.as_json(only: [:id, :name], methods: :image_url)
  end

  def show
    breed = Breed.find(params[:id])
    puts breed.inspect
    render json: breed, serializer: Api::V1::BreedSerializer
  end

  # def show_by_id
  #   breed = Breed.find(params[:id])
  #   render json: breed, serializer: Api::V1::BreedSerializer
  # end

  # def show_by_name
  #   breed = Breed.where('LOWER(name) = ?', params[:name].downcase).first
  #   if breed
  #     render json: breed, serializer: Api::V1::BreedSerializer
  #   else
  #     render json: { error: 'Breed not found' }, status: :not_found
  #   end
  # end

end
