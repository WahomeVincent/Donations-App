class Beneficiary < ApplicationRecord
  belongs_to :charity, optional: true
  belongs_to :donor, optional: true

end
