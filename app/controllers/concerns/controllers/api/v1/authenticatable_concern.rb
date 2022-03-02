# frozen_string_literal: true

module Controllers
  module Api
    module V1
      module AuthenticatableConcern
        extend ActiveSupport::Concern

        included do
          before_action :authenticate_subdomain!
          before_action :authenticate_user!
          before_action :authenticate_site!
        end

        protected

        def authenticate_subdomain!
          return if identify_subdomain.blank?

          Site.find_by!(subdomain: identify_subdomain)
        rescue ActiveRecord::RecordNotFound
          render json: json_unauthorized('Unknown site'), status: :unauthorized
        end

        def authenticate_user!
          render json: json_unauthorized('Authorization token not found'), status: :unauthorized if current_user.blank?
        end

        def authenticate_site!
          render json: json_unauthorized('Site unknown'), status: :unauthorized if current_site.blank?
        end

        def current_user
          @current_user ||= User.find_by(auth_token: identify_user)
        end

        def current_site
          @current_site ||= Site.find_by(subdomain: identify_site)
        end

        private

        def identify_subdomain
          return if request.subdomain.casecmp('www').zero?

          request.subdomain.presence
        end

        def identify_user
          identify_bearer_user ||
            request.headers.fetch('Authorization', nil) ||
            request.headers.fetch('X-Authorization-Token', nil) ||
            request.headers.fetch('X-Auth-Token', nil)
        end

        def identify_site
          identify_subdomain ||
            request.headers.fetch('X-Archangel-Site', nil) ||
            request.headers.fetch('X-Site-Subdomain', nil) ||
            current_user&.user_sites&.first&.site&.subdomain
        end

        def identify_bearer_user
          token = request.headers.fetch('Authorization', '').split.last

          begin
            JsonWebToken.decode(token)['sub']
          rescue JWT::DecodeError
            nil
          end
        end
      end
    end
  end
end
