class Currency < ApplicationRecord
  belongs_to :country
  has_many :flight_offers

  validates :name, :code, :symbol, :country, presence: true
end
