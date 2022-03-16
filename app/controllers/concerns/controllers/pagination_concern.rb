# frozen_string_literal: true

# Controller concern
module Controllers
  # Kaminari pagination
  #
  # Example
  #   class ExamplesController < ApplicationController
  #     include Controllers::PaginationConcern
  #
  #     def index
  #       @examples = Examples.page(page_num).per(per_page)
  #     end
  #   end
  module PaginationConcern
    extend ActiveSupport::Concern

    included do
      helper_method :page_num, :per_page
    end

    # Items per page
    #
    # The number of items to return in pagination. Will use the Kaminari config `default_per_page` (typically `25`)
    # for the count and will look for `per` in the URL paramaters to override.
    #
    # This is accessible from the View as `per_page`
    #
    # Example
    #   /examples?per=100 # Return 100 items per page
    #   /examples?per=10&page=3 # Return page 3 of items with 10 items per page
    #
    # @return [Integer] the number of items per page
    def per_page
      params.fetch(per_page_key, per_page_default).to_i
    end

    # Page number
    #
    # Will look for the Kaminari config `param_name` (typically `page`) in the URL paramaters.
    #
    # This is accessible from the View as `page_num`
    #
    # Example
    #   /examples?page=5 # Return page 5 of items
    #   /examples?per=10&page=3 Return page 3 of items with 10 items per page
    #
    # @return [Integer] the page number
    def page_num
      params.fetch(page_num_key, page_num_default).to_i
    end

    protected

    # Items per page key
    #
    # Query param to be used to identify count to be returned
    def per_page_key
      :per
    end

    # Page numberkey
    #
    # Query param to be used to identify page offset
    def page_num_key
      Kaminari.config.param_name
    end

    private

    def per_page_default
      Kaminari.config.default_per_page
    end

    def page_num_default
      1
    end
  end
end
