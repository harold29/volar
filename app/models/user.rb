# frozen_string_literal: true

class User < ApplicationRecord
  after_initialize :set_default_role

  enum role: %i[user super_user admin]

  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,
         :confirmable, :lockable, :trackable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  private

  def set_default_role
    self.role ||= :user
  end
end
