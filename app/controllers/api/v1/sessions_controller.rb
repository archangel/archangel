# frozen_string_literal: true

# API
module Api
  # API v1
  module V1
    # Sessions API v1
    class SessionsController < V1Controller
      skip_before_action :authenticate_user!, only: %i[create]

      before_action :resource_create_object, only: %i[create]

      # Create session
      #
      # @example Create session
      #   POST /api/v1/session
      def create
        respond_to do |format|
          if @user.present?
            @exp = 24.hours.from_now
            @token = JsonWebToken.encode(sub: @user.auth_token, exp: @exp.to_i)

            format.json { render :create, status: :accepted }
          else
            format.json { render json: json_unauthorized('Error with your login or password'), status: :unauthorized }
          end
        end
      end

      # Destroy session
      #
      # @example Destroy session
      #   DELETE /api/v1/session
      def destroy
        current_user.regenerate_auth_token if current_user.present? && current_site.regenerate_auth_token_on_logout?

        head :no_content
      end

      protected

      def resource_create_object
        email = resource_params.fetch(:email, nil)
        password = resource_params.fetch(:password, nil)
        @user = User.find_for_database_authentication(email: email)

        if @user&.valid_password?(password)
          @user.regenerate_auth_token if current_site.regenerate_auth_token_on_login?
        else
          @user = nil
        end
      end

      def permitted_attributes
        %i[email password]
      end

      def resource_params
        params.permit(permitted_attributes)
      end
    end
  end
end
