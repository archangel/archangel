# frozen_string_literal: true

object @collection_entry
attributes :id, :content, :position, :published_at
attribute discarded_at: :deleted_at
