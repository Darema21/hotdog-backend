class Api::V1::MatchesController < Api::V1::BaseController

  def create
    @match = create_or_update_match
    if @match.valid?
      render json: @match, serializer: Api::V1::MatchShowSerializer
    else
      render_error
    end
  end

  def show
    match = Match.find(params[:id])

    if match
      render json: match, status: :ok, serializer: Api::V1::MatchShowSerializer
    else
      render json: { error: 'Match not found' }, status: :not_found
    end
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

  def create_or_update_match
    from_owner_id = params[:match][:from_owner_id]
    to_owner_id = params[:match][:to_owner_id]
    direction = params[:match][:from_owner_decision]

    puts "from_owner_id: #{from_owner_id}"
    puts "to_owner_id: #{to_owner_id}"
    puts "direction: #{direction}"


    existing_match = Match.find_by(
      "(from_owner_id = :from_owner_id AND to_owner_id = :to_owner_id) OR (from_owner_id = :to_owner_id AND to_owner_id = :from_owner_id)",
      { from_owner_id: from_owner_id, to_owner_id: to_owner_id }
    )

    if existing_match
      puts "Existing match found: #{existing_match.id}"
      update_existing_match(existing_match, direction)
    else
      puts "No existing match found. Creating a new match..."
      create_new_match(from_owner_id, to_owner_id, direction)
    end
  end

  def update_existing_match(match, direction)
    match.to_owner_decision = direction
    match.status = (direction == "right" && match.from_owner_decision == "right") ? "like" : "dislike"
    match.save!
    match
  end

  def create_new_match(from_owner_id, to_owner_id, direction)
    Match.new(
      from_owner_id: from_owner_id,
      to_owner_id: to_owner_id,
      from_owner_decision: direction
    ).tap(&:save)
  end

  def render_error
    render json: { errors: @match.errors.full_messages },
           status: :unprocessable_entity
  end
end
