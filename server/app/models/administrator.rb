class Administrator < ApplicationRecord
    has_one :account
    has_many :charities, through: :account
end
