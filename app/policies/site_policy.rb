# frozen_string_literal: true

# Site authorization policy
class SitePolicy < ApplicationPolicy
  # Can show record
  #
  # @return [Boolean] if authorized
  def show?
    true
  end

  # Can update record
  #
  # Only the `editor` or `admin` role can update a record
  #
  # @return [Boolean] if authorized
  def update?
    editor? || admin?
  end

  # Can history record
  #
  # Only the `admin` role can view record history
  #
  # @return [Boolean] if authorized
  def history?
    admin?
  end

  # Can switch record
  #
  # @return [Boolean] if authorized
  def switch?
    true
  end

  def permitted_attributes
    [
      :name, :subdomain,
      :format_date, :format_datetime, :format_time, :format_js_date, :format_js_datetime, :format_js_time,
      :regenerate_auth_token_on_login, :regenerate_auth_token_on_logout,
      { stores_attributes: %i[id _destroy key value] }
    ]
  end
end
