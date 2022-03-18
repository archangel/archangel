# frozen_string_literal: true

# API
module Api
  # API v1
  module V1
    # Profiles API v1
    class ProfilesController < V1Controller
      before_action :resource_object, only: %i[show update permissions]

      # Show resource
      #
      # @example Show resource
      #   GET /api/v1/profile
      def show; end

      # Update resource
      #
      # @example Update resource
      #   PUT /api/v1/profile
      def update
        respond_to do |format|
          if @profile.update(resource_params)
            format.json { render :update, status: :accepted }
          else
            format.json { render json: json_unprocessable(@profile), status: :unprocessable_entity }
          end
        end
      end

      # Permissions resource
      #
      # @example Permissions resource
      #   GET /api/v1/profile/permissions
      def permissions; end

      protected

      def resource_object
        @profile = current_user

        authorize :profile
      end

      def resource_params
        permitted_attributes = policy(:profile).permitted_attributes

        params.permit(permitted_attributes)
      end
    end
  end
end
