# frozen_string_literal: true

json.extract! site, :id, :name, :token, :created_at, :updated_at
json.url manage_site_url(format: :json)
