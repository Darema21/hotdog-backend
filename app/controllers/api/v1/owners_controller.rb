class Api::V1::OwnersController < Api::V1::BaseController
  def matches
    current_owner = @current_owner
    @matches = current_owner.matches
    @matched_dogs = @matches.map(&:dog)
  end
end
