# frozen_string_literal: true

class ContentPolicy < ApplicationPolicy
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
end
