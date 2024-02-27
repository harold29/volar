# frozen_string_literal: true

class ProfilePolicy < ApplicationPolicy
  def show?
    return false unless user == record.user

    user.user? || user.super_user? || user.admin?
  end

  def create?
    user.user?
  end

  def update?
    return false unless user == record.user

    user.user?
  end
end
