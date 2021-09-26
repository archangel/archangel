# frozen_string_literal: true

json.extract! content, :id, :site_id, :name, :slug, :published_at, :discarded_at, :created_at, :updated_at
json.url manage_content_url(content, format: :json)
