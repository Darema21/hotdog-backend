class Api::V1::BookingsController < Api::V1::BaseController
  # skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_event, only: :create
  # before_action :verify_request
  # after_action :update_for_hire, only: [:create, :destroy]

  def create
    existing_booking = Booking.find_by(event_id: booking_params[:event_id], owner_id: booking_params[:owner_id])
    if existing_booking
      existing_booking.destroy
      render json: existing_booking.event
    else
      @booking = Booking.new(booking_params)
      if @booking.save
        render json: @booking.event
      else
        render json: { error: 'Failed to create booking' }, status: :unprocessable_entity
      end
    end
  end

  private

  def update_for_hire
    owner = @booking.event.owner
    owner.update_for_hire
  end

  def set_event
    @event = Event.find(params[:booking][:event_id])
  end

  def booking_params
    params.require(:booking).permit(:event_id, :owner_id)
  end


end
