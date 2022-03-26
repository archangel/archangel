# frozen_string_literal: true

# API
module Api
  # API v1
  module V1
    # Sites API v1
    class SitesController < V1Controller
      include Controllers::Api::V1::PaperTrailConcern

      before_action :resource_object, only: %i[show update]

      # Show resource
      #
      # @example Show resource
      #   GET /api/v1/site
      #
      # @example Include associated content
      #   GET /api/v1/site?includes=stores
      def show; end

      # Update resource
      #
      # @example Update resource
      #   PUT /api/v1/site
      def update
        respond_to do |format|
          if @site.update(resource_params)
            format.json { render :update, status: :accepted }
          else
            format.json { render json: json_unprocessable(@site), status: :unprocessable_entity }
          end
        end
      end

      protected

      def resource_object
        includes = %w[show].include?(action_name) ? object_include_associations : nil

        @site = Site.where(subdomain: current_site.subdomain).includes(includes).references(includes).first

        authorize :site
      end

      def resource_params
        permitted_attributes = policy(:site).permitted_attributes

        params.permit(permitted_attributes)
      end

      private

      def object_include_associations
        include_associations
      end

      def include_associations
        known_includes = %w[stores]
        default_includes = %w[]

        params.fetch(:includes, default_includes.join(','))
              .split(',')
              .map(&:strip)
              .keep_if { |inc| known_includes.include?(inc) }
      end
    end
  end
end
