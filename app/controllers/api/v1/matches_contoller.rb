class Api::V1::MatchesController < Api::V1::BaseController
  def create
    @match = Match.new(match_params)
  end

  def index
    @matches = Match.includes(:owner, :dog).all
  end

  def destroy
    @match = Match.find(params[:id])
    if @match.destroy
      head :no_content
    else
      render_error
    end
  end

  private

  def match_params
    params.require(:match).permit(:)
  end

  def render_error
    render json: { errors: @match.errors.full_messages },
    status: :unprocessable_entity
  end
end
