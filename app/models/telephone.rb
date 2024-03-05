class Telephone < ApplicationRecord
  belongs_to :user

  enum phone_type: %i[home mobile work other]

  validates :area_code, :phone_number, :phone_type, presence: true
end
