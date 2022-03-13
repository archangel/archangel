# frozen_string_literal: true

# Collection helpers
module CollectionsHelper
  # Collection status
  #
  # @example With Collection resource that is discarded
  #   <%= collection_status(resource) %> #=> 'deleted'
  #
  # @example With Collection resource that has not been published
  #   <%= collection_status(resource) %> #=> 'draft'
  #
  # @example With Collection resource that is published but not available
  #   <%= collection_status(resource) %> #=> 'scheduled'
  #
  # @example With Collection resource that is currently available
  #   <%= collection_status(resource) %> #=> 'available'
  #
  # @param [Object] resource Collection object
  # @return [String] status name
  def collection_status(resource)
    return 'deleted' if resource.discarded?
    return 'draft' if resource.unpublished?
    return 'scheduled' if resource.scheduled?

    'available'
  end
end
