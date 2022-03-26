# frozen_string_literal: true

# API
module Api
  # API v1
  module V1
    # Contents API v1
    class ContentsController < V1Controller
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
      # @todo Query; name, slug, body
      #
      # @example All resources
      #   GET /api/v1/contents
      #
      # @example All resources sorted by name
      #   GET /api/v1/contents?sort=name
      #   GET /api/v1/contents?sort=-name
      #
      # @example All resources sorted by slug
      #   GET /api/v1/contents?sort=slug
      #   GET /api/v1/contents?sort=-slug
      #
      # @example Include associated content
      #   GET /api/v1/contents?includes=stores
      #
      # @example All resources paginated
      #   GET /api/v1/contents?per=100
      #   GET /api/v1/contents?page=2&per=12
      def index; end

      # Show resource
      #
      # @todo Filter; include unpublished, include deleted
      #
      # @example Show resource
      #   GET /api/v1/contents/{slug}
      #
      # @example Include associated content
      #   GET /api/v1/contents/{slug}?includes=stores
      def show; end

      # Create resource
      #
      # @example Create resource
      #   POST /api/v1/contents
      def create
        respond_to do |format|
          if @content.save
            format.json { render :create, status: :created }
          else
            format.json { render json: json_unprocessable(@content), status: :unprocessable_entity }
          end
        end
      end

      # Update resource
      #
      # @example Update resource
      #   PUT /api/v1/contents/{slug}
      def update
        respond_to do |format|
          if @content.update(resource_params)
            format.json { render :update, status: :accepted }
          else
            format.json { render json: json_unprocessable(@content), status: :unprocessable_entity }
          end
        end
      end

      # Delete or destroy resource
      #
      # When the resource has not been discarded (soft deleted), the record will be marked as discarded. When the
      # resource is already discarded, the record will be hard deleted
      #
      # @example Delete or destroy resource
      #   DELETE /api/v1/contents/{slug}
      def destroy
        @content.discarded? ? @content.destroy : @content.discard

        respond_to do |format|
          format.json { head :no_content }
        end
      end

      # Restore resource
      #
      # When a resource has been discarded (soft deleted), the record will be marked as undiscarded
      #
      # @example Restore resource
      #   POST /api/v1/contents/{slug}/restore
      def restore
        @content.undiscard

        respond_to do |format|
          format.json { head :accepted }
        end
      end

      protected

      def resource_collection
        @contents = retrieve(
          current_site.contents
                      .includes(collection_include_associations).references(collection_include_associations)
        ).page(page_num).per(per_page)

        authorize :content
      end

      def resource_object
        content_id = params.fetch(:id, '')
        includes = %w[show].include?(action_name) ? object_include_associations : nil

        @content = current_site.contents
                               .includes(includes).references(includes)
                               .find_by!(slug: content_id)

        authorize :content
      rescue ActiveRecord::RecordNotFound
        render json: json_not_found(controller_name), status: :not_found
      end

      def resource_create_object
        @content = current_site.contents.new(resource_params)

        authorize :content
      end

      def resource_params
        permitted_attributes = policy(:content).permitted_attributes

        params.permit(permitted_attributes)
      end

      private

      def collection_include_associations
        include_associations
      end

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
