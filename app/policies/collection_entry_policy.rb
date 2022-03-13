# frozen_string_literal: true

# Collection Entry authorization policy
class CollectionEntryPolicy < ApplicationPolicy
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

  # Can restore record
  #
  # Only the `admin` role can restore a record
  #
  # @return [Boolean] if authorized
  def restore?
    admin?
  end

  # Can reposition record
  #
  # Only the `editor` or `admin` role can reposition a record
  #
  # @return [Boolean] if authorized
  def reposition?
    editor? || admin?
  end
end
