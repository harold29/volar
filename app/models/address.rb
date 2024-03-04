class Address < ApplicationRecord
  belongs_to :profile
  belongs_to :country

  enum address_type: %i[home work]

  validates :address_line_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
  validates :address_type, presence: true
end
