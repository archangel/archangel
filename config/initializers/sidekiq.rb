# frozen_string_literal: true

redis_provider = ENV.fetch('REDIS_PROVIDER', 'localhost:6379')

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{redis_provider}/0" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis_provider}/0" }
end
