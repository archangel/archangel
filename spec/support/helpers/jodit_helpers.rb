# frozen_string_literal: true

module Archangel
  module TestingSupport
    module JoditHelpers
      ##
      # Fill in Jodit WYSIWYG field
      #
      # Note that `js: true` is required for this to function correctly
      #
      # Example
      #   fill_in_jodit('My Field Label', with: '<p>Content for my field</p>')
      #
      def fill_in_jodit(locator, params = {})
        return unless page.has_css?('label', text: locator)

        id = find('label', text: locator)[:for]
        value = params.fetch(:with, '')

        selector = "label[for='#{id}'] + .jodit-container .jodit-wysiwyg[contenteditable]"

        find(selector).set(value)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::JoditHelpers, type: :system, js: true
end
