class Api::V1::DogsController < Api::V1::BaseController

  def index
    # @dogs = Dog.includes(:owner, images_attachments: :blob).all
    # @dogs = Dog.where.not(id: current_user.matches.pluck(:to_owner_id))
    owner = Owner.find(2)
    @dogs = Dog.where.not(id: owner.matches.pluck(:to_owner_id)).order(Arel.sql('RANDOM()'))
    render json: @dogs, each_serializer: Api::V1::DogIndexSerializer
  end

  def update
    if @dog.update(dog_params)
      render :show
    else
      render_error
    end
  end

  def create
    @dog = Dog.new(dog_params)
    if @dog.save
      render :show, status: :created
    else
      render_error
    end
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
    params.require(:dog).permit(:name, :gender, :age, :neutered, :vaccinated, :bio, :address, images: [])
  end

  def render_error
    render json: { errors: @dog.errors.full_messages },
    status: :unprocessable_entity
  end

end

# index, create, update, show, destroy
