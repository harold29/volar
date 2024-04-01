class Traveler < ApplicationRecord
  belongs_to :user
  belongs_to :document
  belongs_to :telephone

  #TODO: update relationships with booking and
  enum traveler_type: %i[adult child infant]

  validates :first_name, :last_name, :email, :birthdate, presence: true
  validates :traveler_type, presence: true, inclusion: { in: %w[adult child infant] }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :telephone, :document, presence: true
  validates :birthdate, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: 'must be in the format YYYY-MM-DD' }
end
