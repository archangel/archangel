# frozen_string_literal: true

module Api
  class V1Controller < ApiController
    include ::Controllers::Api::V1::TokenAuthenticatableConcern

    # rescue_from ActiveRecord::RecordNotFound, with: -> { render json: { error: 'Not found' }, status: :not_found }

    def current_site
      @current_site ||= Site.first
    end

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

    protected

    def json_unprocessable_errors(resource_errors)
      errors = {}

      resource_errors.each do |error|
        errors[error.attribute] = {
          short: error.message,
          long: error.full_message
        }
      end

      errors
    end
  end
end
