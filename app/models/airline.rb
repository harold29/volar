class Airline < ApplicationRecord
  validates :name, presence: true
  validates :logo, presence: true
end
