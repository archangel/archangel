# frozen_string_literal: true

module Api
  module V1
    class ContentsController < V1Controller
      before_action :resource_collection, only: %i[index]
      before_action :resource_object, only: %i[show update destroy]
      before_action :resource_create_object, only: %i[create]

      def index; end

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
        @content.discard

        respond_to do |format|
          format.json { head :no_content }
        end
      end

      protected

      def resource_collection
        @contents = current_site.contents.kept.order(name: :asc)
      end

      def resource_object
        content_id = params.fetch(:id, '')

        @content = current_site.contents.kept.find_by!(slug: content_id)
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
