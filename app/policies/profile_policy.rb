# frozen_string_literal: true

class ProfilePolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    true
  end

  def retoken?
    true
  end
end
