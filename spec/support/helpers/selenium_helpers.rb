# frozen_string_literal: true

module Archangel
  module TestingSupport
    module SeleniumHelpers
      ##
      # Check if Selenium test
      #
      # Check if the test driver is not `:rack_test` (default driver). Anything other than `:rack_test` is considered a
      # Selenium test
      #
      def selenium?
        Capybara.current_driver != :rack_test
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::SeleniumHelpers, type: :system
end
