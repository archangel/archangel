# frozen_string_literal: true

require 'capybara/rails'
require 'capybara/rspec'

Capybara.configure do |config|
  config.default_max_wait_time = 10
end

# https://github.com/teamcapybara/capybara/issues/2419
RSpec.configure do |config|
  config.before do
    # Rack tests (not `js: true` enabled) do not need options configured)
    Capybara.configure do |conf|
      conf.default_set_options = {}
    end
  end

  config.before(:each, js: true) do
    # Selenium tests (`js: true` enabled) need options configured)
    Capybara.configure do |conf|
      conf.default_set_options = { clear: :backspace }
    end
  end
end
