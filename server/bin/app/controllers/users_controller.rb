class UsersController < ApplicationController
  before_action :authenticate_request, except: [:authenticate, :create, :destroy, :check_login]
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    users = User.all
    render json: users
  end

  def check_login
    token = cookies.signed[:token]
    logged_in = token.present? && current_user_id.present?
    render json: { logged_in: logged_in, token: token }
  end

  def authenticate
    user = User.find_by(email: params[:email])

    if user.nil?
      render json: { errors: "Account not found for that email address" }, status: :not_found
    elsif user.authenticate(params[:password])
      token = generate_token(user)
      role_message = "Welcome!"

    
      cookies.signed[:token] = { value: token, httponly: true }
      render json: { token: token, message: role_message }, status: :ok
    else
      render json: { errors: "Invalid password" }, status: :unauthorized
    end
  end

  def create
    user = User.new(user_params)
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]
  
    if user.save
      token = generate_token(user)
      role = Role.create(role_type: "donor", user_id: user.id) # Create the role with the user's ID
      cookies.signed[:token] = { value: token, httponly: true }
      render json: { token: token, message: "Role created: donor" }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  
    
  

  def show
    user = User.includes(:voter).find_by(id: current_user_id)
    render json: user.as_json(include: :voter)
  end

  def destroy
    cookies.delete(:token)
    render json: { message: "User successfully logged out" }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def record_invalid(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def not_found
    render json: { errors: "Record not found" }, status: :not_found
  end

  def current_user_id
    token = request.headers["Authorization"]&.split(" ")&.last
    decoded_token = decode(token)
    decoded_token&.dig(:user_id)
  end

  def generate_token(user)
    encode({ user_id: user.id, email: user.email })
  end

  def encode(payload)
    JWT.encode(payload, Rails.application.credentials.secret_key_base, "HS256")
  end

  def decode(token)
    decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: "HS256").first
    HashWithIndifferentAccess.new(decoded_token)
  rescue JWT::DecodeError, JWT::ExpiredSignature
    nil
  end

  def authenticate_request
    render json: { errors: "Unauthorized" }, status: :unauthorized unless current_user_id && authorized_user?
  end

  def authorized_user?
    current_user&.user? || current_user&.admin_clerk?
  end
end