class User < ApplicationRecord
  has_secure_password
  has_one :account
  has_and_belongs_to_many :roles
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
