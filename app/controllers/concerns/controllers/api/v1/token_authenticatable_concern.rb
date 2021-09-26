# frozen_string_literal: true

module Controllers
  module Api
    module V1
      module TokenAuthenticatableConcern
        extend ActiveSupport::Concern

        included do
          attr_reader :current_user

          before_action :authenticate_user

          rescue_from NotAuthorizedException, with: lambda { |message|
            render json: json_unauthorized(message), status: :unauthorized
          }
        end

        private

        def authenticate_user
          decode_result = DecodeAuthenticationService.call(request.headers)

          @current_user = decode_result.result

          raise NotAuthorizedException, decode_result.errors.first.message unless @current_user
        end
      end
    end
  end
end

class NotAuthorizedException < StandardError; end
