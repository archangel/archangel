# frozen_string_literal: true

object @collection
attributes :name, :slug, :published_at
attribute discarded_at: :deleted_at

child :collection_fields, root: :fields, if: ->(obj) { obj.association(:collection_fields).loaded? } do
  extends 'api/v1/collection_fields/item'
end

child :collection_entries, root: :entries, if: ->(obj) { obj.association(:collection_entries).loaded? } do
  extends 'api/v1/collections/collection_entries/item'
end
