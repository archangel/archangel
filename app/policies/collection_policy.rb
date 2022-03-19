# frozen_string_literal: true

# Collection authorization policy
class CollectionPolicy < ApplicationPolicy
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

  # Can history record
  #
  # Only the `admin` role can view record history
  #
  # @return [Boolean] if authorized
  def history?
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

  def permitted_attributes
    [
      :name, :published_at, :slug,
      {
        collection_fields_attributes: %i[id _destroy classification key label required]
      }
    ]
  end
end
