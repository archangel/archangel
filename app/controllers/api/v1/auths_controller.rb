# frozen_string_literal: true

module Api
  module V1
    class AuthsController < V1Controller
      skip_before_action :authenticate_user
      before_action :resource_create_object, only: %i[create]

      def create
        respond_to do |format|
          if @user.success?
            format.json { render :create, status: :accepted }
          else
            format.json { render json: json_unauthorized(@user.errors.full_messages.first), status: :unauthorized }
          end
        end
      end

      protected

      def resource_create_object
        fallback_resource_params = resource_params.reverse_merge(email: '', password: '')

        @user = AuthenticateUserService.call(*fallback_resource_params.values)
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
