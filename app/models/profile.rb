# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user
  has_many :addresses

  # validates_format_of :email,:with => Devise::email_regexp
  # validates :email, presence: true, uniqueness: true

  validates :phone_number_1, presence: true,
                             uniqueness: true,
                             length: {
                               minimum: 10,
                               maximum: 15
                             }

  validates :phone_number_2, allow_nil: true,
                             length: {
                               minimum: 10,
                               maximum: 15
                             }

  validates :first_name, presence: true
  validates :last_name, presence: true
end
