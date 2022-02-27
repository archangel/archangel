# frozen_string_literal: true

object @content
attributes :name, :slug, :body, :published_at
attribute discarded_at: :deleted_at
child :stores do
  extends 'api/v1/stores/item'
end
