# frozen_string_literal: true

# User helpers
module UsersHelper
  # User status
  #
  # @example With User resource that has not been confirmed
  #   <%= user_status(resource) %> #=> 'unconfirmed'
  #
  # @example With User resource that is currently locked
  #   <%= user_status(resource) %> #=> 'locked'
  #
  # @example With User resource that is generally available
  #   <%= user_status(resource) %> #=> 'available'
  #
  # @param [Object] resource User object
  # @return [String] status name
  def user_status(resource)
    return 'unconfirmed' if resource.confirmed?
    return 'locked' if resource.access_locked?

    'available'
  end
end
