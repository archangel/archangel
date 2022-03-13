# frozen_string_literal: true

# User Site authorization policy
class UserSitePolicy < ApplicationPolicy
  # Can destroy record
  #
  # Only the `admin` role can destroy a record
  #
  # @return [Boolean] if authorized
  def destroy?
    admin?
  end
end
