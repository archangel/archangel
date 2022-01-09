# frozen_string_literal: true

module Archangel
  module TestingSupport
    module FlatpickrHelpers
      ##
      # Fill in flatpickr datetime_picker input field
      #
      # Note that `js: true` is required for this to function correctly
      #
      # Example
      #   select_flatpickr_date(1.day.ago, from: 'Field Label')
      #
      def select_flatpickr_date(value, **options)
        from = options.fetch(:from, nil)
        value = processed_date(value)

        return unless page.has_css?('label', text: from)

        id = find('label', text: from)[:for]
        selector = "label[for='#{id}'] + input[type='hidden'] + input"

        find(selector).set(value)
        page.execute_script("document.querySelector('.flatpickr-calendar.open').classList.remove('open')")
      end

      protected

      def processed_date(value)
        format = '%m-%d-%Y %H:%M'

        return value.to_datetime.strftime(format) if value.respond_to?(:to_date)

        Time.zone.parse(value).strftime(format)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::FlatpickrHelpers, type: :system, js: true
end
