# frozen_string_literal: true

object @collection
attributes :name, :slug, :published_at
attribute discarded_at: :deleted_at
child collection_fields: :fields do
  extends 'api/v1/collection_fields/item'
end
