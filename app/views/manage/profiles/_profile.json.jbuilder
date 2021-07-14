# frozen_string_literal: true

json.extract! site, :id, :first_name, :last_name, :username, :email, :created_at, :updated_at
json.url manage_profile_url(format: :json)
