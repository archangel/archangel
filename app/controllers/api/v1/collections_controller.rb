# frozen_string_literal: true

module Api
  module V1
    class CollectionsController < V1Controller
      before_action :resource_collection, only: %i[index]
      before_action :resource_object, only: %i[show update destroy]
      before_action :resource_create_object, only: %i[create]

      def index; end

      def show; end

      def create
        respond_to do |format|
          if @collection.save
            format.json { render :create, status: :created }
          else
            format.json { render json: json_unprocessable(@collection), status: :unprocessable_entity }
          end
        end
      end

      def update
        respond_to do |format|
          if @collection.update(resource_params)
            format.json { render :update, status: :accepted }
          else
            format.json { render json: json_unprocessable(@collection), status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @collection.discard

        respond_to do |format|
          format.json { head :no_content }
        end
      end

      protected

      def resource_collection
        @collections = current_site.collections.kept.order(name: :asc)
      end

      def resource_object
        collection_id = params.fetch(:id, '')

        @collection = current_site.collections.kept.find_by!(slug: collection_id)
      rescue ActiveRecord::RecordNotFound
        render json: json_not_found(controller_name), status: :not_found
      end

      def resource_create_object
        @collection = current_site.collections.new(resource_params)
      end

      def permitted_attributes
        %i[name published_at slug]
      end

      def resource_params
        params.permit(permitted_attributes)
      end
    end
  end
end
