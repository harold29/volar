class Country < ApplicationRecord
  has_one :currency

  validates :name, presence: true
  validates :code, presence: true
  validates :phone_code, presence: true
  validates :language, presence: true
  validates :continent, presence: true
  validates :time_zone, presence: true
end
