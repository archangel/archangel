# frozen_string_literal: true

module Manage
  module Collections
    class CollectionEntriesController < ManageController
      include Controllers::PaginationConcern

      before_action :set_collection
      before_action :set_collection_entries, only: %i[index]
      before_action :set_collection_entry, only: %i[show edit update destroy]
      before_action :set_new_collection_entry, only: %i[new]
      before_action :set_create_collection_entry, only: %i[create]
      before_action :set_restore_collection_entry, only: %i[restore]
      before_action :set_reposition_collection_entry, only: %i[reposition]

      def index; end

      def show; end

      def new; end

      def create
        respond_to do |format|
          if @collection_entry.save
            format.html do
              redirect_to manage_collection_collection_entry_path(@collection, @collection_entry),
                          notice: I18n.t('flash.collection_entries.create.success')
            end
            format.json do
              render :show, status: :created,
                            location: manage_collection_collection_entry_path(@collection, @collection_entry)
            end
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @collection_entry.errors, status: :unprocessable_entity }
          end
        end
      end

      def edit; end

      def update
        respond_to do |format|
          if @collection_entry.update(resource_params)
            format.html do
              redirect_to manage_collection_collection_entry_path(@collection, @collection_entry),
                          notice: I18n.t('flash.collection_entries.update.success')
            end
            format.json do
              render :show, status: :ok, location: manage_collection_collection_entry_path(@collection, @collection_entry)
            end
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @collection_entry.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @collection_entry.discarded? ? @collection_entry.destroy : @collection_entry.discard

        respond_to do |format|
          format.html do
            redirect_to manage_collection_collection_entries_path(@collection),
                        notice: I18n.t('flash.collection_entries.destroy.success')
          end
          format.json { head :no_content }
        end
      end

      def restore
        @collection_entry.undiscard

        respond_to do |format|
          format.html do
            redirect_to manage_collection_collection_entries_path(@collection),
                        notice: I18n.t('flash.collection_entries.restore.success')
          end
          format.json { head :no_content }
        end
      end

      def reposition
        new_positions = params.fetch(:collection_entry).fetch(:positions, [])
        positions = {}.tap do |option|
          new_positions.each.with_index { |id, index| option[id] = { position: index } }
        end

        @collection.collection_entries.with_discarded.update(positions.keys, positions.values)

        render json: { message: I18n.t('flash.collection_entries.reposition.success') }
      end

      protected

      def permitted_attributes
        fields = collection_field_key_map.map(&:to_sym)

        fields + %i[published_at]
      end

      def set_collection
        resource_id = params.fetch(:collection_id, nil)

        @collection = current_site.collections.with_discarded.find(resource_id)

        skip_authorization
      end

      def set_collection_entries
        @collection_entries = @collection.collection_entries.page(page_num).per(per_page)

        authorize @collection_entries
      end

      def set_collection_entry
        resource_id = params.fetch(:id, nil)

        @collection_entry = @collection.collection_entries.with_discarded.find(resource_id)

        authorize @collection_entry
      end

      def set_new_collection_entry
        @collection_entry = @collection.collection_entries.new

        authorize @collection_entry
      end

      def set_create_collection_entry
        entry_resource = @collection.collection_entries.new(nil)

        collection_field_key_map.each do |field|
          entry_resource.assign_attributes(field => resource_params.fetch(field, nil))
        end

        entry_resource[:published_at] = resource_params.fetch(:published_at, nil)

        authorize @collection_entry = entry_resource
      end

      def set_restore_collection_entry
        resource_id = params.fetch(:id, nil)

        @collection_entry = @collection.collection_entries.with_discarded.find(resource_id)

        authorize @collection_entry
      end

      def set_reposition_collection_entry
        @collection_entries = @collection.collection_entries.with_discarded

        authorize @collection_entries
      end

      def resource_params
        params.require(:collection_entry).permit(permitted_attributes)
      end

      private

      def collection_field_key_map
        @collection.collection_fields.map(&:key)
      end
    end
  end
end
