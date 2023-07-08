class Api::V1::MatchesController < Api::V1::BaseController
  def create
    dog = Dog.find(params[:dog_id]) #will change later after front-end is finished
    current_owner = Owner.find(params[:id])
    @match = Match.new
    @match.from_owner = current_owner
    @match.to_owner = dog.owner
  end

  # def index
  #   @matches = Match.includes(:owner, :dog).all
  #   current_owner = @current_owner
  #   @my_matches = current_owner.matches
  # end

  def show
    owner = Owner.find(params[:owner_id])
    @match = Match.includes(:owner, :dog).find(params[:id])
    owner.match
  end

  def destroy
    current_owner = Owner.find(params[:id])
    @match = Match.find(params[:id])
    if current_owner.match.destroy
      head :no_content
    else
      render_error
    end
  end

  private


  def render_error
    render json: { errors: @match.errors.full_messages },
    status: :unprocessable_entity
  end
end

#create, show, destroy
