# frozen_string_literal: true

module UsersHelper
  def user_status(resource)
    return 'unconfirmed' if resource.confirmed?
    return 'locked' if resource.access_locked?

    'available'
  end
end
