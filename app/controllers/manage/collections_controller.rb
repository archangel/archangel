# frozen_string_literal: true

# Manage (admin)
module Manage
  # Collection
  class CollectionsController < ManageController
    include Controllers::PaginationConcern

    before_action :set_collections, only: %i[index]
    before_action :set_collection, only: %i[show edit update destroy]
    before_action :set_new_collection, only: %i[new]
    before_action :set_create_collection, only: %i[create]
    before_action :set_restore_collection, only: %i[restore]

    # All resources
    #
    # @example All resources
    #   GET /manage/collections
    def index; end

    # Show resource
    #
    # @example Show resource
    #   GET /manage/collections/{id}
    def show; end

    # New resource
    #
    # @example New resource
    #   GET /manage/collections/new
    def new
      nested_resource_build
    end

    # Create resource
    #
    # @example Create resource
    #   POST /manage/collections
    def create
      respond_to do |format|
        if @collection.save
          format.html do
            redirect_to manage_collection_path(@collection), notice: I18n.t('flash.collections.create.success')
          end
          format.json { render :show, status: :created, location: manage_collection_path(@collection) }
        else
          nested_resource_build
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @collection.errors, status: :unprocessable_entity }
        end
      end
    end

    # Edit resource
    #
    # @example Edit resource
    #   GET /manage/collections/{id}/edit
    def edit
      nested_resource_build
    end

    # Update resource
    #
    # @example Update resource
    #   PUT /manage/collections/{id}
    def update
      respond_to do |format|
        if @collection.update(resource_params)
          format.html do
            redirect_to manage_collection_path(@collection), notice: I18n.t('flash.collections.update.success')
          end
          format.json { render :show, status: :ok, location: manage_collection_path(@collection) }
        else
          nested_resource_build
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @collection.errors, status: :unprocessable_entity }
        end
      end
    end

    # Delete or destroy resource
    #
    # When the resource has not been discarded (soft deleted), the record will be marked as discarded. When the
    # resource is already discarded, the record will be hard deleted
    #
    # @example Delete or destroy resource
    #   DELETE /manage/collections/{id}
    def destroy
      @collection.discarded? ? @collection.destroy : @collection.discard

      respond_to do |format|
        format.html { redirect_to manage_collections_path, notice: I18n.t('flash.collections.destroy.success') }
        format.json { head :no_content }
      end
    end

    # Restore resource
    #
    # When a resource has been discarded (soft deleted), the record will be marked as undiscarded
    #
    # @example Restore resource
    #   POST /manage/collections/{id}/restore
    def restore
      @collection.undiscard

      respond_to do |format|
        format.html { redirect_to manage_collections_path, notice: I18n.t('flash.collections.restore.success') }
        format.json { head :no_content }
      end
    end

    protected

    def nested_resource_build
      @collection.collection_fields.build if @collection.collection_fields.blank?
    end

    def set_collections
      @collections = current_site.collections.with_discarded.order(name: :asc).page(page_num).per(per_page)

      authorize @collections
    end

    def set_collection
      resource_id = params.fetch(:id, nil)

      @collection = current_site.collections.with_discarded.find(resource_id)

      authorize @collection
    end

    def set_new_collection
      @collection = current_site.collections.new

      authorize @collection
    end

    def set_create_collection
      @collection = current_site.collections.new(resource_params)

      authorize @collection
    end

    def set_restore_collection
      resource_id = params.fetch(:id, nil)

      @collection = current_site.collections.with_discarded.find(resource_id)

      authorize @collection
    end

    def resource_params
      permitted_attributes = policy(:collection).permitted_attributes

      params.require(:collection).permit(permitted_attributes)
    end
  end
end
