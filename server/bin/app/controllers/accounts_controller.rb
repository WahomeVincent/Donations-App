class AccountsController < ApplicationController
  before_action :set_account, only: %i[update destroy show]

  # GET /users/:user_id/accounts
  def index
    user = User.find_by(id: params[:user_id])

    if user.nil?
      render json: { error: "User not found. Please create an account." }, status: :not_found
    else
      @account = user.account

      if @account.nil?
        render json: { error: "You do not have an account. Please create an account." }, status: :not_found
      else
        session[:account_sid] = @account.id
        # Add any other logic or rendering as required here.
        render json: { message: "User account information rendered successfully." }, status: :ok
      end
    end
  end

  # GET /accounts
  def show_all_accounts
    @accounts = Account.all
    render json: @accounts
  end

  # GET /accounts/:id
  def show
    if @account
      render json: { account: @account.as_json(include: [:beneficiaries]) }
    else
      render json: { error: "Account not found." }, status: :not_found
    end
  end

  # POST /users/:user_id/accounts
  def create
    user = User.find_by(id: params[:user_id])

    if user.nil?
      render json: { error: "User not found. Please create an account." }, status: :not_found
    else
      # Check if the user already has an account
      if user.account
        render json: { error: "User already has an account. Cannot create another account." }, status: :unprocessable_entity
        return
      end

      # Generate a random account number by concatenating params[:user_id] with a random number.
      account_number = params[:user_id].to_s + rand(1000000..9999999).to_s

      # Create a new account associated with the user using the correct association method.
      @account = user.create_account(account_params.merge(account_number: account_number))

      session[:current_account_id] = @account.id
      session[:account_sid] = @account.id

      if @account.valid?
        render json: { session: session[:account_sid] }, status: :ok
      else
        render json: { errors: @account.errors }, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /accounts/:id
  def update
    if @account.update(account_params)
      render json: @account, status: :ok
    else
      render json: { error: @account.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/:id
  def destroy
    @account.destroy
    head :no_content
  end

  private

  def set_account
    @account = Account.find_by(id: params[:id])
  end

  def account_params
    params.permit(:image, :email, :mobile, :name).merge(user_id: params[:user_id])
  end
end
