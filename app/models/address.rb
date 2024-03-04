class Address < ApplicationRecord
  belongs_to :profile
  belongs_to :country

  enum address_type: %i[home work]

  validates :address_line_1, :city, :state, :postal_code, :address_type, presence: true
end
