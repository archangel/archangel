# frozen_string_literal: true

module Archangel
  module TestingSupport
    module JavascriptHelpers
      ##
      # Wait for condition
      #
      # Wait for condition to be met. This does not have a dependency on jQuery. It watches for a condition to be met
      # before continuing. Or fails after a number of seconds.
      #
      # Example
      #   it 'massages data before form submit' do
      #     click_button 'Publish Resource'
      #
      #     # Wait for there to be a toast message. Fail out after 10 seconds
      #     wait_for { page.has_css?('.toast.toast-success') }
      #
      #     expect(page.find('.slug.resource_slug')).to have_content('has already been taken')
      #   end
      #
      #   wait_for(30) { page.has_css?('.toast.toast-success') } # Wait up to 30 seconds
      #
      def wait_for(timeout = Capybara.default_max_wait_time)
        counter = 0
        delay_threshold = timeout * 10

        until yield
          counter += 1

          sleep(0.1)

          raise "Could not achieve condition within #{timeout} seconds." if counter >= delay_threshold
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::JavascriptHelpers, type: :system, js: true
end
