# frozen_string_literal: true

# Dashboard authorization policy
class DashboardPolicy < ApplicationPolicy
  # Can show record
  #
  # @return [Boolean] if authorized
  def show?
    true
  end
end
