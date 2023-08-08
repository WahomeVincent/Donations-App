class CharitiesController < ApplicationController
  # User Story: A donor should be able to see a variety of charities they can donate to
  def index
    @charities = Charity.all
    render json: @charities
  end

  # User Story: A charity should be able to apply to be a charity on the platform
  def create
    @charity = Charity.new(charity_params)
    if @charity.save
      render json: @charity
    else
      render json: { errors: @charity.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # User Story: A charity should be able to view non-anonymous donors and their donations
  def show_donors
    @charity = Charity.find_by(id: params[:id])
    if @charity
      @donors = @charity.donors.where.not(id: nil)
      render json: @donors
    else
      render json: { errors: ["Charity not found."] }, status: :not_found
    end
  end

  # User Story: A charity should be able to view the amounts donated by anonymous donors
  def show_anonymous_donations
    @charity = Charity.find_by(id: params[:id])
    if @charity
      @donations = @charity.donations.where(donor_id: nil)
      render json: @donations
    else
      render json: { errors: ["Charity not found."] }, status: :not_found
    end
  end

  # User Story: A charity should be able to view the total amount donated to the charity
  def show_total_donations
    @charity = Charity.find_by(id: params[:id])
    if @charity
      @total_donations = @charity.donations.sum(:amount)
      render json: { total_donations: @total_donations }
    else
      render json: { errors: ["Charity not found."] }, status: :not_found
    end
  end

  # User Story: An administrator should be able to approve a charity
  def approve
    @charity = Charity.find_by(id: params[:id])
    if @charity
      @charity.update(approved: true)
      DonorMailer.charity_approval_email(@charity).deliver_later
      render json: @charity
    else
      render json: { errors: ["Charity not found."] }, status: :not_found
    end
  end

  # User Story: A charity should be able to create and post stories of beneficiaries
  def create_beneficiary_story
    @charity = Charity.find_by(id: params[:id])
    if @charity
      @beneficiary = Beneficiary.new(beneficiary_params.merge(charity: @charity))
      if @beneficiary.save
        render json: @beneficiary
      else
        render json: { errors: @beneficiary.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: ["Charity not found."] }, status: :not_found
    end
  end
  

    # User Story: An administrator should be able to reject a charity
    def reject
      @charity = Charity.find_by(id: params[:id])
      if @charity
        DonorMailer.charity_rejection_email(@charity).deliver_later
        @charity.destroy
        head :no_content
      else
        render json: { errors: ["Charity not found."] }, status: :not_found
      end
    end
  

  # User Story: A charity should be able to maintain a list of beneficiaries and inventory
  def show_beneficiaries
    @charity = Charity.find_by(id: params[:id])
    if @charity
      @beneficiaries = @charity.beneficiaries
      render json: @beneficiaries
    else
      render json: { errors: ["Charity not found."] }, status: :not_found
    end
  end

  private

  def charity_params
    params.require(:charity).permit(:name, :description)
  end

  def beneficiary_params
    params.require(:beneficiary).permit(:name, :description, :inventory)
  end
end
