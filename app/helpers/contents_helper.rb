# frozen_string_literal: true

# Content helpers
module ContentsHelper
  # Content status
  #
  # @example With Content resource that is discarded
  #   <%= content_status(resource) %> #=> 'deleted'
  #
  # @example With Content resource that has not been published
  #   <%= content_status(resource) %> #=> 'draft'
  #
  # @example With Content resource that is published but not available
  #   <%= content_status(resource) %> #=> 'scheduled'
  #
  # @example With Content resource that is currently available
  #   <%= content_status(resource) %> #=> 'available'
  #
  # @param [Object] resource Content object
  # @return [String] status name
  def content_status(resource)
    return 'deleted' if resource.discarded?
    return 'draft' if resource.unpublished?
    return 'scheduled' if resource.scheduled?

    'available'
  end
end
