# frozen_string_literal: true

# Profile authorization policy
class ProfilePolicy < ApplicationPolicy
  # Can show record
  #
  # @return [Boolean] if authorized
  def show?
    true
  end

  # Can update record
  #
  # @return [Boolean] if authorized
  def update?
    true
  end

  # Can retoken record
  #
  # @return [Boolean] if authorized
  def retoken?
    true
  end

  # Permissions listing
  #
  # Used in API
  #
  # @return [Boolean] if authorized
  def permissions?
    true
  end

  def permitted_attributes
    %i[email first_name last_name password password_confirmation username]
  end
end
