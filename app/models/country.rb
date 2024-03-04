class Country < ApplicationRecord
  has_one :currency
  has_many :addresses

  validates :name, :code, :phone_code, :language, :continent, :time_zone, presence: true
end
