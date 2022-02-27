# frozen_string_literal: true

module Api
  module V1
    class SitesController < V1Controller
      before_action :resource_object, only: %i[show update]

      def show; end

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
        @site = current_site
      end

      def permitted_attributes
        [
          :name, :subdomain,
          :format_date, :format_datetime, :format_time, :format_js_date, :format_js_datetime, :format_js_time,
          { stores_attributes: %i[id _destroy key value] }
        ]
      end

      def resource_params
        params.permit(permitted_attributes)
      end
    end
  end
end
