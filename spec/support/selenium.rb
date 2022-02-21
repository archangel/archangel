# frozen_string_literal: true

require 'selenium/webdriver'
require 'webdrivers'

Capybara.register_driver :selenium_chrome_headless do |app|
  Selenium::WebDriver.logger.level = :error

  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w[headless no-sandbox disable-gpu window-size=1920,1080]
  )

  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: :chrome, options: options)
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end
end
