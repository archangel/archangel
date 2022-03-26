# frozen_string_literal: true

# API
module Api
  # API v1
  module V1
    # Collections API v1
    class CollectionsController < V1Controller
      include Toller
      include Controllers::Api::V1::PaginationConcern
      include Controllers::Api::V1::PaperTrailConcern

      sort_on :name, type: :scope, scope_name: :sort_on_name, default: true
      sort_on :slug, type: :scope, scope_name: :sort_on_slug

      before_action :resource_collection, only: %i[index]
      before_action :resource_object, only: %i[show update destroy restore]
      before_action :resource_create_object, only: %i[create]

      # All resources
      #
      # @todo Filter; include unpublished, include deleted
      # @todo Query; name, slug
      #
      # @example All resources
      #   GET /api/v1/collections
      #
      # @example All resources sorted by name
      #   GET /api/v1/collections?sort=name
      #   GET /api/v1/collections?sort=-name
      #
      # @example All resources sorted by slug
      #   GET /api/v1/collections?sort=slug
      #   GET /api/v1/collections?sort=-slug
      #
      # @example All resources paginated
      #   GET /api/v1/collections?per=100
      #   GET /api/v1/collections?page=2&per=12
      def index; end

      # Show resource
      #
      # @todo Filter; include unpublished, include deleted
      #
      # @example Show resource
      #   GET /api/v1/collections/{slug}
      def show; end

      # Create resource
      #
      # @example Create resource
      #   POST /api/v1/collections
      def create
        respond_to do |format|
          if @collection.save
            format.json { render :create, status: :created }
          else
            format.json { render json: json_unprocessable(@collection), status: :unprocessable_entity }
          end
        end
      end

      # Update resource
      #
      # @example Update resource
      #   PUT /api/v1/collections/{slug}
      def update
        respond_to do |format|
          if @collection.update(resource_params)
            format.json { render :update, status: :accepted }
          else
            format.json { render json: json_unprocessable(@collection), status: :unprocessable_entity }
          end
        end
      end

      # Delete or destroy resource
      #
      # When the resource has not been discarded (soft deleted), the record will be marked as discarded. When the
      # resource is already discarded, the record will be hard deleted
      #
      # @example Delete or destroy resource
      #   DELETE /api/v1/collections/{slug}
      def destroy
        @collection.discarded? ? @collection.destroy : @collection.discard

        respond_to do |format|
          format.json { head :no_content }
        end
      end

      # Restore resource
      #
      # When a resource has been discarded (soft deleted), the record will be marked as undiscarded
      #
      # @example Restore resource
      #   POST /api/v1/collections/{slug}/restore
      def restore
        @collection.undiscard

        respond_to do |format|
          format.json { head :accepted }
        end
      end

      protected

      def resource_collection
        includes = %i[collection_fields]

        @collections = retrieve(
          current_site.collections.includes(includes)
        ).page(page_num).per(per_page)

        authorize :collection
      end

      def resource_object
        collection_id = params.fetch(:id, '')

        @collection = current_site.collections.find_by!(slug: collection_id)

        authorize :collection
      rescue ActiveRecord::RecordNotFound
        render json: json_not_found(controller_name), status: :not_found
      end

      def resource_create_object
        @collection = current_site.collections.new(resource_params)

        authorize :collection
      end

      def resource_params
        permitted_attributes = policy(:collection).permitted_attributes

        params.permit(permitted_attributes)
      end
    end
  end
end
