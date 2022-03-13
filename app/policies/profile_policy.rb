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
end
