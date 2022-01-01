# frozen_string_literal: true

json.extract! collection_entry, :id, :site_id, :name, :key, :published_at, :discarded_at, :created_at, :updated_at
json.url manage_collection_collection_entry_url(collection_entry.collection, collection_entry, format: :json)
