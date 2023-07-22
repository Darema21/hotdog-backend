class Api::V1::MatchesController < Api::V1::BaseController

  # skip_before_action :verify_authenticity_token

  def create
    from_owner_id = params[:match][:from_owner_id]
    to_owner_id = params[:match][:to_owner_id]
    direction = params[:match][:from_owner_decision]

    existing_match = Match.find_by(
      "(from_owner_id = :from_owner_id AND to_owner_id = :to_owner_id) OR (from_owner_id = :to_owner_id AND to_owner_id = :from_owner_id)",
      { from_owner_id: from_owner_id, to_owner_id: to_owner_id }
    )

    if existing_match
      existing_match.to_owner_decision = direction
      if existing_match.to_owner_decision == "right" && existing_match.from_owner_decision  == "right"
        existing_match.status = "like"
      else
        existing_match.status = "dislike"
      end
      existing_match.save!
      render json: existing_match
    else
      # dog = Dog.find(params[:dog_id])
      # current_owner = Owner.find(params[:id])
      @match = Match.new(
        from_owner_id: from_owner_id,
        to_owner_id: to_owner_id,
        from_owner_decision: direction
      )

      if @match.save
        render json: @match, status: :created
      else
        render_error("Failed to create match", :unprocessable_entity)
      end
    end
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
