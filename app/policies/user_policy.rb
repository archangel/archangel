# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    admin?
  end

  def update?
    editor? || admin?
  end

  def destroy?
    admin?
  end

  def reinvite?
    editor? || admin?
  end

  def unlock?
    editor? || admin?
  end
end
