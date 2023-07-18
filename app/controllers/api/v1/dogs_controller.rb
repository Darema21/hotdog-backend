class Api::V1::DogsController < Api::V1::BaseController
  # skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

  def index
    @dogs = policy_scope(Dog).all
    # @dogs = policy_scope(Dog.includes(:owner, images_attachment: :blob)).all
  end

  def update
    # authorize @dog

    if @dog.update(dog_params)
      render :show
    else
      render_error
    end
  end

  def create
    @dog = Dog.new(dog_params)
    @dog.owner = current_owner

    authorize @dog

    if @dog.save
      render :show, status: :created
    else
      render_error
    end
  end

  def upload_image
    @dog = Dog.find(params[:id])
    @dog.images.attach(params[:images])
  end

  def show
    # authorize @dog
    @dog = Dog.find(params[:id])
  end

  def destroy
    # authorize @dog
    if @dog.destroy
      head :no_content
    else
      render_error
    end
  end

  private

  def set_dog
    @dog = Event.find(params[:id])
    authorize @dog
  end

  def dog_params
    params.require(:dog).permit(:name, :gender, :age, :neutered, :vaccinated, :bio, :address, images: [])
  end

  def render_error
    render json: { errors: @dog.errors.full_messages },
    status: :unprocessable_entity
  end
end

# index, create, update, show, destroy
