class Currency < ApplicationRecord
  belongs_to :country
  has_many :flight_offers

  validates :name, presence: true
  validates :code, presence: true
  validates :symbol, presence: true
  validates :country, presence: true
end
