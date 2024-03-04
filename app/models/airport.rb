class Airport < ApplicationRecord
  belongs_to :country

  validates :name, :city, :iata_code, :time_zone, :country, presence: true
end
