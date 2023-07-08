class Api::V1::OwnersController < Api::V1::BaseController
  def matches
    current_owner = @current_owner
    @matches = current_owner.matches
    @matched_dogs = @matches.map(&:dog)

  def update
    if @owner.update(owner_params)
      render :show
    else
      render_error
    end
  end

  def deactivate
    @owner = Owner.find(params[:id])
    @owner.update(status: false)
  end

  private

  def owner_params
    params.require(:owner).permit(:name, :age, :gender, :active)
  end

  def render_error
    render json: { errors: @owner.errors.full_messages },
    status: :unprocessable_entity
  end
end
