class Api::V1::DogsController < Api::V1::BaseController
  before_action :verify_request

  def index
    owner = @current_owner
    current_owner_dog = owner.dog

    p "---------current_owner_dog---------"
    p  current_owner_dog
    p current_owner_dog.image_urls
    p "---------------------------------"


    subquery = owner.from_matches.select(:to_owner_id)
    matched_owner_ids = owner.to_matches.where(status: ["like", "dislike"]).pluck(:from_owner_id)

    puts "-----------"
    puts "owner: #{owner.inspect}"
    puts "current_owner_dog: #{current_owner_dog.inspect}"
    puts "subquery: #{subquery.inspect}"
    puts "matched_owner_ids: #{matched_owner_ids.inspect}"
    puts "-----------"

    @dogs = Dog.where.not(owner_id: subquery)
                .where.not(owner_id: @current_owner&.id)
                .where.not(owner_id: matched_owner_ids)
                .order(Arel.sql('RANDOM()'))

    render json: {
      dogs: ActiveModel::Serializer::CollectionSerializer.new(@dogs, serializer: Api::V1::DogIndexSerializer),
      current_owner_dog: current_owner_dog,
      current_owner_dog_image: current_owner_dog.image_urls
    }
  end

  def update
    if @dog.update(dog_params)
      render :show
    else
      render_error
    end
  end

  def create
    p dog_params[:breed]
    breed = Breed.where(name:dog_params[:breed])[0]
    p "-------------breed------------"
    p breed
    p "----------------------------"
    p dog_params

    @dog = Dog.new(
      dog_params.except(:breed)
    )
    @dog.breed = breed
    if @dog.save
      render json: @dog, serializer: Api::V1::DogShowSerializer
    else
      render_error
    end
  end

  def upload
    @dog = Dog.find(params[:id])
    puts "params #{params}"
    @dog.image.attach(params[:image])
    render json: {msg: 'Image upload success!'}
  end

  def show
    @dog = Dog.includes(:owner, images_attachments: :blob).find(params[:id])
    render json: @dog, serializer: Api::V1::DogShowSerializer
  end


  def destroy
    if @dog.destroy
      head :no_content
    else
      render_error
    end
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :gender, :breed, :age, :neutered, :vaccinated, :bio, :address, :owner_id)
  end

  def render_error
    render json: { errors: @dog.errors.full_messages },
    status: :unprocessable_entity
  end

end

# index, create, update, show, destroy
