# frozen_string_literal: true

# Controller concern
module Controllers
  # Controller API concern
  module Api
    # Controller API v1 concern
    module V1
      # Controller API v1 pagination concern
      module PaginationConcern
        extend ActiveSupport::Concern

        included do
          after_action :set_pagination_headers, only: %i[index]
        end

        # Pagination headers
        #
        # Set pagination object in header object
        def set_pagination_headers
          response.headers['X-Pagination'] = pagination_header_object.to_json
        end

        # Per page count
        #
        # Number of records to return per set of results. Look for URL param to identify per page count. If not found,
        # return default
        #
        # @return [Integer] per page count
        def per_page
          params.fetch(per_page_key, per_page_default).to_i
        end

        # Page number
        #
        # Look for URL param to identify current page. If not found, return 1
        #
        # @return [Integer] page number
        def page_num
          params.fetch(page_num_key, page_num_default).to_i
        end

        protected

        def pagination_controller_name
          controller_name
        end

        def per_page_key
          :per_page
        end

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

        def pagination_header_object
          results = instance_variable_get("@#{pagination_controller_name}")

          {
            total: results.total_count,
            count: results.size,
            limit: results.limit_value,
            offset: results.offset_value,
            total_pages: results.total_pages,
            previous_page: results.prev_page,
            current_page: results.current_page,
            next_page: results.next_page,
            first_page: results.first_page?,
            last_page: results.last_page?,
            out_of_bounds: results.out_of_range?
          }
        end
      end
    end
  end
end
