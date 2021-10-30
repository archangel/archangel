# frozen_string_literal: true

class UserSitePolicy < ApplicationPolicy
  def destroy?
    admin?
  end
end
