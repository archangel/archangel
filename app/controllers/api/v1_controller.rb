# frozen_string_literal: true

# API
module Api
  # API v1 base
  class V1Controller < ApiController
    include Pundit::Authorization
    include ::Controllers::Api::V1::ErrorConcern
    include ::Controllers::Api::V1::AuthenticatableConcern

    rescue_from Pundit::NotAuthorizedError, with: :render_error_unauthorized

    after_action :set_version_header
    after_action :verify_authorized

    protected

    def render_error_unauthorized
      render json: json_unauthorized('Unauthorized'), status: :unauthorized
    end

    private

    def set_version_header
      response.headers['X-Api-Version'] = 'V1'
    end
  end
end
