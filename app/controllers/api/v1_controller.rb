# frozen_string_literal: true

# API
module Api
  # API v1 base
  class V1Controller < ApiController
    include ::Controllers::Api::V1::ErrorConcern
    include ::Controllers::Api::V1::AuthenticatableConcern

    after_action :set_version_header

    private

    def set_version_header
      response.headers['X-Api-Version'] = 'V1'
    end
  end
end
