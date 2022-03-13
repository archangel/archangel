# frozen_string_literal: true

# Site authorization policy
class SitePolicy < ApplicationPolicy
  # Can show record
  #
  # @return [Boolean] if authorized
  def show?
    true
  end

  # Can update record
  #
  # Only the `editor` or `admin` role can update a record
  #
  # @return [Boolean] if authorized
  def update?
    editor? || admin?
  end

  # Can switch record
  #
  # @return [Boolean] if authorized
  def switch?
    true
  end
end
