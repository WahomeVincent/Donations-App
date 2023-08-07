class DonorsController < ApplicationController
  # User Story: A donor should be able to create an account on the platform
  def create
    @user = User.find_by(id: params[:user_id])
    @donor = Donor.new(donor_params)
  
    if @donor.save
      account_number = @donor.id.to_s + rand(1000000..9999999).to_s
      @account = Account.new(
        name: @donor.name,
        email: @donor.email,
        mobile: @donor.mobile,
        user_id: @user.id,
        account_number: account_number,
        image: @donor.image,
        donor_id: @donor.id  # Ensure donor_id is set instead of user_id
      )
      if @account.save
        render json: { message: "Donor, Account, and Charity successfully created." }, status: :ok
      else
        render json: { errors: @account.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: @donor.errors.full_messages }, status: :unprocessable_entity
    end
  end
  

  # User Story: A donor should be able to choose a charity to donate to
  def donate
    @donor = Donor.find_by(id: params[:id])
    @charity = Charity.find_by(id: params[:charity_id])
  
    if @donor && @charity
      @beneficiary = Beneficiary.new(
        name: @charity.name,
        email: @charity.email,
        image: @charity.image,
        phonenumber: @charity.phonenumber,
        donor_id: @donor.id,
        charity_id: @charity.id,
        description: @charity.description
      )
  
      if @beneficiary.save
        if params[:amount].to_i > 0
          @donation = Donation.new(donor: @donor, charity: @charity, amount: params[:amount])
          if @donation.save
            DonorMailer.donation_successful_email(@donor, @charity, @donation.amount).deliver_now
            render json: { message: "Donation successful." }, status: :ok
          else
            render json: { errors: @donation.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: ["Invalid donation amount. Please provide a positive number."] }, status: :unprocessable_entity
        end
      else
        render json: { errors: @beneficiary.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: ["Donor or charity not found."] }, status: :not_found
    end
  end
  
  

  # User Story: A donor should be able to set up automated repeat donation or one-time donation
  def set_donation_recurring
    @donor = Donor.find_by(id: params[:id])
    if @donor
      @donor.update(repeat_donation: true)
      DonorMailer.donation_reminder_email(@donor, @donor.next_donation_date).deliver_later(wait_until: @donor.next_donation_date)
    else
      render json: { errors: ["Donor not found."] }, status: :not_found
    end
  end

  # User Story: A donor should be able to choose whether to be an anonymous donor or not
  def set_donation_anonymous
    @donor = Donor.find_by(id: params[:id])
    if @donor
      @donor.update(anonymous: params[:anonymous])
      render json: @donor
    else
      render json: { errors: ["Donor not found."] }, status: :not_found
    end
  end

  # User Story: A donor should be able to see stories about beneficiaries of their donations
  def show_beneficiary_stories
    @donor = Donor.find_by(id: params[:id])
    if @donor
      @beneficiaries = Beneficiary.joins(:donations).where(donations: { donor_id: @donor.id })
      render json: @beneficiaries
    else
      render json: { errors: ["Donor not found."] }, status: :not_found
    end
  end

  private

  def donor_params
    params.require(:donor).permit(:name, :email, :mobile, :image)
  end
end
