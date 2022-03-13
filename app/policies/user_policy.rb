# frozen_string_literal: true

# User authorization policy
class UserPolicy < ApplicationPolicy
  # Can view records
  #
  # @return [Boolean] if authorized
  def index?
    true
  end

  # Can show record
  #
  # @return [Boolean] if authorized
  def show?
    true
  end

  # Can create record
  #
  # Only the `admin` role can create a record
  #
  # @return [Boolean] if authorized
  def create?
    admin?
  end

  # Can update record
  #
  # Only the `editor` or `admin` role can update a record
  #
  # @return [Boolean] if authorized
  def update?
    editor? || admin?
  end

  # Can destroy record
  #
  # Only the `admin` role can destroy a record
  #
  # @return [Boolean] if authorized
  def destroy?
    admin?
  end

  # Can reinvite record
  #
  # Only the `editor` or `admin` role can reinvite a record
  #
  # @return [Boolean] if authorized
  def reinvite?
    editor? || admin?
  end

  # Can retoken record
  #
  # Only the `editor` or `admin` role can retoken a record
  #
  # @return [Boolean] if authorized
  def retoken?
    editor? || admin?
  end

  # Can unlock record
  #
  # Only the `editor` or `admin` role can unlock a record
  #
  # @return [Boolean] if authorized
  def unlock?
    editor? || admin?
  end
end
