class Account < ApplicationRecord
  belongs_to :user
  belongs_to :donor, optional: true
  belongs_to :administrator, optional: true
  belongs_to :charity, optional: true
end
