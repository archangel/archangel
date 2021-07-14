# frozen_string_literal: true

RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers

  config.before { freeze_time }
  config.after { unfreeze_time }
end
