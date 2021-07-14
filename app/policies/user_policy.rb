# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    manager? || admin?
  end

  def update?
    manager? || editor? || admin?
  end

  def destroy?
    admin?
  end
end
