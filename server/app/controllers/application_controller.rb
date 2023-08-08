class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :authenticate_request

  private

  def authenticate_request
    unless current_user_id && authorized_user?
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def authorized_user?
    current_user.present?
  end

  def current_user_id
    token = request.headers["Authorization"]&.split(" ")&.last
    decoded_token = decode(token)
    decoded_token&.dig(:user_id)
  end

  def current_user
    @current_user ||= User.find_by(id: current_user_id)
  end

  def decode(token)
    decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: "HS256").first
    HashWithIndifferentAccess.new(decoded_token)
  rescue JWT::DecodeError, JWT::ExpiredSignature => e
    # Log the error or return a specific error message to the client
    nil
  end
end