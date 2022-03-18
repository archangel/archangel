# frozen_string_literal: true

# API
module Api
  # API v1
  module V1
    # Collection API v1
    module Collections
      # Collection Entries API v1
      class CollectionEntriesController < V1Controller
        include Toller
        include ::Controllers::Api::V1::PaginationConcern

        before_action :parent_resource
        before_action :resource_collection, only: %i[index]
        before_action :resource_object, only: %i[show update destroy restore]
        before_action :resource_create_object, only: %i[create]
        before_action :resource_reposition_collection, only: %i[reposition]

        # All resources
        #
        # @todo Filter; include unpublished, include deleted, include Collection and Field info
        #
        # @example All resources
        #   GET /api/v1/collections/{slug}/entries
        #
        # @example All resources paginated
        #   GET /api/v1/collections/{slug}/entries?per=100
        #   GET /api/v1/collections/{slug}/entries?page=2&per=12
        def index; end

        # Show resource
        #
        # @todo Filter; include unpublished, include deleted, include Collection and Field info
        #
        # @example Show resource
        #   GET /api/v1/collections/{slug}/entries/{id}
        def show; end

        # Create resource
        #
        # @example Create resource
        #   POST /api/v1/collections/{slug}/entries
        def create
          respond_to do |format|
            if @collection_entry.save
              format.json { render :create, status: :created }
            else
              format.json { render json: json_unprocessable(@collection_entry), status: :unprocessable_entity }
            end
          end
        end

        # Update resource
        #
        # @example Update resource
        #   PUT /api/v1/collections/{slug}/entries/{id}
        def update
          respond_to do |format|
            if @collection_entry.update(resource_params)
              format.json { render :update, status: :accepted }
            else
              format.json { render json: json_unprocessable(@collection_entry), status: :unprocessable_entity }
            end
          end
        end

        # Delete or destroy resource
        #
        # When the resource has not been discarded (soft deleted), the record will be marked as discarded. When the
        # resource is already discarded, the record will be hard deleted
        #
        # @example Delete or destroy resource
        #   DELETE /api/v1/collections/{slug}/entries/{id}
        def destroy
          @collection_entry.discarded? ? @collection_entry.destroy : @collection_entry.discard

          respond_to do |format|
            format.json { head :no_content }
          end
        end

        # Reposition resource
        #
        # @example Reposition resource
        #   POST /api/v1/collections/{slug}/entries/reposition
        def reposition
          new_positions = params.fetch(:positions, [])
          positions = {}.tap do |option|
            new_positions.each.with_index { |id, index| option[id] = { position: index } }
          end

          @collection.collection_entries.update(positions.keys, positions.values)

          respond_to do |format|
            format.json { head :accepted }
          end
        end

        # Restore resource
        #
        # When a resource has been discarded (soft deleted), the record will be marked as undiscarded
        #
        # @example Restore resource
        #   POST /api/v1/collections/{slug}/entries/{id}/restore
        def restore
          @collection_entry.undiscard

          respond_to do |format|
            format.json { head :accepted }
          end
        end

        protected

        def parent_resource
          resource_id = params.fetch(:collection_id, nil)

          @collection = current_site.collections.find_by!(slug: resource_id)
        rescue ActiveRecord::RecordNotFound
          render json: json_not_found(controller_name), status: :not_found
        end

        def resource_collection
          @collection_entries = @collection.collection_entries.order(position: :asc).page(page_num).per(per_page)

          authorize @collection_entries
        end

        def resource_object
          resource_id = params.fetch(:id, '')

          @collection_entry = @collection.collection_entries.find_by!(id: resource_id)

          authorize @collection_entry
        rescue ActiveRecord::RecordNotFound
          render json: json_not_found(controller_name), status: :not_found
        end

        def resource_create_object
          entry_resource = @collection.collection_entries.new(nil)

          collection_field_key_map.each do |field|
            entry_resource.assign_attributes(field => resource_params.fetch(field, nil))
          end

          entry_resource[:published_at] = resource_params.fetch(:published_at, nil)

          @collection_entry = entry_resource

          authorize @collection_entry
        end

        def resource_reposition_collection
          @collection_entries = @collection.collection_entries.all

          authorize @collection_entries
        end

        def permitted_attributes
          fields = collection_field_key_map.map(&:to_sym)

          fields + %i[published_at]
        end

        def resource_params
          params.permit(permitted_attributes)
        end

        private

        def collection_field_key_map
          @collection.collection_fields.map(&:key)
        end
      end
    end
  end
end
