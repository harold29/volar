class Document < ApplicationRecord
  belongs_to :issuance_country, class_name: 'Country'
  belongs_to :nationality, class_name: 'Country'

  enum document_type: %i[passport national_id driver_license visa other]

  validates :document_number, :expiration_date, :issuance_country, :nationality, presence: true
  validates :document_type, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
