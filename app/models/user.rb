# frozen_string_literal: true

class User < ApplicationRecord
  after_initialize :set_default_role

  enum role: %i[user super_user admin]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :lockable, :trackable

  private

  def set_default_role
    self.role ||= :user
  end
end
