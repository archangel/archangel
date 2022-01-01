# frozen_string_literal: true

module Archangel
  module TestingSupport
    module DragHelpers
      ##
      # Drag and drop
      #
      # Used to test Sortable.js actions when repositioning resources. Note that `js: true` is required for this to
      # function correctly
      #
      # Example
      #   drag_item('.wrapper-container', '.draggable-item', 3, 1) # Drag item 3 to position 1
      #   drag_item('table tbody', 'tr', 1, 2) # Drag item 1 to position 2
      #
      def drag_item(container, item, from_index, to_index)
        within(container) do
          draggable = page.find("#{item}:nth-child(#{from_index})")
          droppable = page.find("#{item}:nth-child(#{to_index})")

          draggable.drag_to(droppable)
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::DragHelpers, type: :system, js: true
end
