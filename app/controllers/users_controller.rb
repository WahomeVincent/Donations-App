class UsersController < ApplicationController
    #skip_before_action :authorize, only: [:create]
   before_action :authorize, only: [:index]
    rescue_from ActiveRecord::RecordNotFound, with: :render_response_error   
    rescue_from ActiveRecord::RecordInvalid, with: :render_error
    
    def index
        user = User.all
        render json: user
    end

    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user
    end

    # def show
    #     user = User.find(session[:user_id])
    #     render json: user
    # end

    def show
        user = User.find_by(id: session[:user_id])
        render json: user
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
    end

    private

    def authorize
        user = User.find_by(id: session[:user_id])
        render json: { errors: ["Not authorized"] }, status: :unauthorized unless user
    end

    def user_params
        params.permit(:email, :password, :password_confirmation)
    end

    
    def render_error
        render json: {error: "User not found"}, status: :not_found
    end

    def render_response_error
        render json: {error: "Not found"}, status: :not_found
    end 

   
end