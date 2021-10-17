# frozen_string_literal: true

module ContentsHelper
  def content_status(resource)
    return 'deleted' if resource.discarded?
    return 'draft' if resource.unpublished?
    return 'scheduled' if resource.scheduled?

    'available'
  end
end
