# frozen_string_literal: true

class UserSite < ApplicationRecord
  after_initialize :assign_default_values

  ##
  # Roles
  #
  # 0: Can view, edit, update and delete
  # 1: Can view, create and update but not delete
  # 2: Can view but not create, update or delete
  #
  ROLES = {
    admin: 0,
    editor: 1,
    reader: 2
  }.freeze

  ##
  # Default role
  #
  # Default role to assign to Users. Assign to "reader" role by default
  #
  ROLE_DEFAULT = 1

  enum role: ROLES

  belongs_to :site
  belongs_to :user

  validates :role, presence: true, inclusion: { in: roles.keys }

  protected

  def assign_default_values
    self.role = ROLE_DEFAULT if role.blank?
  end
end
