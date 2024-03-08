class Amenity < ApplicationRecord
  belongs_to :fare_details_by_segment

  validates :description, presence: true
  validates :amenity_type, presence: true
  validates :amenity_provider_name, presence: true

  validates :is_chargeable, inclusion: { in: [true, false] }
end
