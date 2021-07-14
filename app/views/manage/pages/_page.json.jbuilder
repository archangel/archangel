# frozen_string_literal: true

json.extract! page, :id, :site_id, :title, :slug, :published_at, :discarded_at, :created_at, :updated_at
json.url manage_page_url(page, format: :json)
