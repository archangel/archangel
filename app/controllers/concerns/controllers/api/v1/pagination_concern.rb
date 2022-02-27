# frozen_string_literal: true

module Controllers
  module Api
    module V1
      module PaginationConcern
        extend ActiveSupport::Concern

        included do
          after_action :set_pagination_headers, only: %i[index]
        end

        def set_pagination_headers
          response.headers['X-Pagination'] = pagination_header_object.to_json
        end

        def per_page
          params.fetch(per_page_key, per_page_default).to_i
        end

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
