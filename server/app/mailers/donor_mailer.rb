# app/mailers/donor_mailer.rb
class DonorMailer < ApplicationMailer
    def account_creation_email(donor)
      @donor = donor
      mail(to: @donor.email, subject: 'Welcome to our Donation Platform!')
    end
#   new method for  succefull donation
    def donation_successful_email(donor, charity, amount)
      @donor = donor
      @charity = charity
      @amount = amount
      mail(to: @donor.email, subject: 'Thank You for Your Donation!')
    end
#   new Method for donation reminder
    def donation_reminder_email(donor, charity, donation_date)
      @donor = donor
      @charity = charity
      @donation_date = donation_date
      mail(to: @donor.email, subject: 'Donation Reminder')
    end
      # New method for charity approval email
  def charity_approval_email(donor, charity)
    @donor = donor
    @charity = charity
    mail(to: @donor.email, subject: 'Charity Approved')
  end


      # New method for charity rejection email
  def charity_rejection_email(donor, charity)
    @donor = donor
    @charity = charity
    mail(to: @donor.email, subject: 'Charity Rejected')
  end
  end
  