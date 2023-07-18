class ApplicationController < ActionController::API
  before_action :verify_authenticity_token
end
