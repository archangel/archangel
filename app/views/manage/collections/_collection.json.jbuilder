# frozen_string_literal: true

json.extract! collection, :id, :site_id, :name, :slug, :published_at, :discarded_at, :created_at, :updated_at
json.url manage_collection_url(collection, format: :json)
