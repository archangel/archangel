# frozen_string_literal: true

class CollectionEntryPolicy < ApplicationPolicy
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

  def restore?
    admin?
  end

  def reposition?
    editor? || admin?
  end
end
