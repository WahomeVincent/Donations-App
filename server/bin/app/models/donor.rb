class Donor < ApplicationRecord
  has_one :account
  has_many :donations
  has_many :charities, through: :donations
  has_many :beneficiaries
end
