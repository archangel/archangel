# frozen_string_literal: true

module Api
  module V1
    class CollectionsController < V1Controller
      include ::Controllers::Api::V1::PaginationConcern

      before_action :resource_collection, only: %i[index]
      before_action :resource_object, only: %i[show update destroy restore]
      before_action :resource_create_object, only: %i[create]

      # TODO: Filter; include unpublished, include deleted
      # TODO: Query; name, slug
      def index; end

      # TODO: Filter; include unpublished, include deleted
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
        @collection.discarded? ? @collection.destroy : @collection.discard

        respond_to do |format|
          format.json { head :no_content }
        end
      end

      def restore
        @collection.undiscard

        respond_to do |format|
          format.json { head :accepted }
        end
      end

      protected

      def resource_collection
        includes = %i[collection_fields]

        @collections = current_site.collections.includes(includes).order(name: :asc).page(page_num).per(per_page)
      end

      def resource_object
        collection_id = params.fetch(:id, '')

        @collection = current_site.collections.find_by!(slug: collection_id)
      rescue ActiveRecord::RecordNotFound
        render json: json_not_found(controller_name), status: :not_found
      end

      def resource_create_object
        @collection = current_site.collections.new(resource_params)
      end

      def permitted_attributes
        [
          :name, :published_at, :slug,
          {
            collection_fields_attributes: %i[id _destroy classification key label required]
          }
        ]
      end

      def resource_params
        params.permit(permitted_attributes)
      end
    end
  end
end
