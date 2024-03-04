class Stop < ApplicationRecord
  belongs_to :segment
  belongs_to :airport

  validates :segment, :airport, :duration, :arrival_at, :departure_at, presence: true
end
