class Api::V1::OwnersController < Api::V1::BaseController

  def matches
    owner = @current_owner
    @matches = Match.where(status: "like")
                    .where("(from_owner_id = ?) OR (to_owner_id = ?)", owner.id, owner.id)
    render json: @matches, each_serializer: Api::V1::MatchIndexSerializer, current_owner: owner
  end

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
