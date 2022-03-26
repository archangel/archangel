# frozen_string_literal: true

object @content
attributes :name, :slug, :body, :published_at
attribute discarded_at: :deleted_at

child :stores, if: ->(obj) { obj.association(:stores).loaded? } do
  extends 'api/v1/stores/item'
end
