# frozen_string_literal: true

module Controllers
  module Api
    module V1
      module ErrorConcern
        extend ActiveSupport::Concern

        protected

        def json_not_found(resource)
          {
            success: false,
            status: 404,
            message: I18n.t("api.not_found.#{resource}")
          }
        end

        def json_unprocessable(resource)
          {
            success: false,
            status: 422,
            errors: json_unprocessable_errors(resource.errors)
          }
        end

        def json_unauthorized(error)
          {
            success: false,
            status: 401,
            message: error
          }
        end

        private

        def json_unprocessable_errors(resource_errors)
          {}.tap do |errors|
            resource_errors.each do |error|
              errors[error.attribute] = {
                short: error.message,
                long: error.full_message
              }
            end
          end
        end
      end
    end
  end
end
