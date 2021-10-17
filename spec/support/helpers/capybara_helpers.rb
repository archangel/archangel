# frozen_string_literal: true

module Archangel
  module TestingSupport
    module CapybaraHelpers
      ##
      # Within Table Row
      #
      # The index of the first child is 1
      #
      # Example
      #   it 'has content in the second row' do
      #     within_row(2) { expect(page).to have_content('This is the content of the second row') }
      #   end
      #
      #   it 'allows deleting a resource' do
      #     within_row(2) do
      #       click_on 'Delete Resource'
      #     end
      #
      #     expect(page).to have_content('Resource was successfully destroyed.')
      #   end
      #
      def within_row(num, &block)
        within("table.table tbody tr:nth-child(#{num})", match: :first, &block)
      end

      def js_driver
        Capybara.current_driver != :rack_test
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::CapybaraHelpers, type: :system
end
