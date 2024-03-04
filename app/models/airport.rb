class Airport < ApplicationRecord
  belongs_to :country

  validates :name, presence: true
  validates :city, presence: true
  validates :iata_code, presence: true
  validates :time_zone, presence: true
  validates :country, presence: true
end
