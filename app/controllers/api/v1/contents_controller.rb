# frozen_string_literal: true

module Api
  module V1
    class ContentsController < V1Controller
      before_action :resource_collection, only: %i[index]
      before_action :resource_object, only: %i[show update destroy restore]
      before_action :resource_create_object, only: %i[create]

      # TODO: Filter; include unpublished, include deleted
      # TODO: Query; name, slug, body
      # TODO: Pagination; page, per_page
      def index; end

      # TODO: Filter; include unpublished, include deleted
      def show; end

      def create
        respond_to do |format|
          if @content.save
            format.json { render :create, status: :created }
          else
            format.json { render json: json_unprocessable(@content), status: :unprocessable_entity }
          end
        end
      end

      def update
        respond_to do |format|
          if @content.update(resource_params)
            format.json { render :update, status: :accepted }
          else
            format.json { render json: json_unprocessable(@content), status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @content.discarded? ? @content.destroy : @content.discard

        respond_to do |format|
          format.json { head :no_content }
        end
      end

      def restore
        @content.undiscard

        respond_to do |format|
          format.json { head :accepted }
        end
      end

      protected

      def resource_collection
        includes = %i[stores]

        @contents = current_site.contents.includes(includes).order(name: :asc)
      end

      def resource_object
        content_id = params.fetch(:id, '')

        @content = current_site.contents.find_by!(slug: content_id)
      rescue ActiveRecord::RecordNotFound
        render json: json_not_found(controller_name), status: :not_found
      end

      def resource_create_object
        @content = current_site.contents.new(resource_params)
      end

      def permitted_attributes
        [
          :body, :name, :slug,
          { stores_attributes: %i[id _destroy key value] }
        ]
      end

      def resource_params
        params.permit(permitted_attributes)
      end
    end
  end
end
