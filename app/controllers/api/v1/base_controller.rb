class Api::V1::BaseController < ActionController::Base

  # rescue_from StandardError,                with: :internal_server_error
  # rescue_from ActiveRecord::RecordNotFound, with: :not_found
  HMAC_SECRET = Rails.application.credentials.dig(:jwt, :hmac_secret)
  skip_before_action :verify_authenticity_token
  # before_action :verify_request, except: [:index]

  private

  def verify_request
    token = get_jwt_token
    puts "This is the token #{token}"

    if token.present?
      data = jwt_decode(token)
      owner_id = data[:owner_id]
      @current_owner = Owner.find(owner_id) # set current user by user_id in JWT payload
      puts "@current_owner #{@current_owner.id}"
    else
      render json: { error: 'Missing JWT token.' }, status: 401
    end
  end

  def jwt_decode(token) # decode JWT, then turn payload into a hash
    decoded_info = JWT.decode(token, HMAC_SECRET, { algorithm: 'HS256' })[0] # extract the payload
    HashWithIndifferentAccess.new decoded_info
  end

  # retrieve token from headers
  def get_jwt_token
    puts " request.headers['X-USER-TOKEN'] #{request.headers['X-USER-TOKEN']}"
    request.headers['X-USER-TOKEN']
  end

  # def not_found(exception)
  #   render json: { error: exception.message }, status: :not_found
  # end

  # def internal_server_error(exception)
  #   if Rails.env.development?
  #     response = { type: exception.class.to_s, error: exception.message }
  #   else
  #     response = { error: "Internal Server Error" }
  #   end
  #   render json: response, status: :internal_server_error
  # end
end
