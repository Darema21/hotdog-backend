class Api::V1::EventsController < Api::V1::BaseController
  before_action :set_event, only: [ :show, :update, :destroy, :upload_image ]
  # skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

  def index
    @events = Event.all
  end

  def create
    @event = Event.new(event_params)
    @event.owner = current_owner


    if @event.save
      render :show, status: :created
    else
      render_error
    end
  end


  def upload_image

  end

  def show
    # authorize @event
    @booking = Booking.new
  end

  def update
    # authorize @event

    if @event.update(event_params)
      render :show
    else
      render_error
    end
  end

  # def destroy
  #   if @event.destroy
  #   else
  #     render_error
  #   end
  # end

  def category
    category = params[:category]
    @events = Event.where(category: category)
    render :index
    # # authorize @event
    # @event.destroy
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :address, :start_time, :end_time, :category, :owner_id, :image)
  end

  def render_error
    render json: { errors: @event.errors.full_messages },
    status: :unprocessable_entity
  end
end

# darema 6.29 line 52 added :image
