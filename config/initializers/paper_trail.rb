# frozen_string_literal: true

require 'history_change_adapter'

PaperTrail.config do |config|
  config.object_changes_adapter = HistoryChangeAdapter.new
  config.version_limit = ENV.fetch('PAPERTRAIL_VERSION_LIMIT', 12)
end
