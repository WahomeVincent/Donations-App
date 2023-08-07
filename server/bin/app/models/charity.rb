class Charity < ApplicationRecord
  belongs_to :administrator
  has_one :account
  has_many :donations
  has_many :donors, through: :account
end
