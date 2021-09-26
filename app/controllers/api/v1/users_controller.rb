# frozen_string_literal: true

module Api
  module V1
    class UsersController < V1Controller
      before_action :resource_object, only: %i[show destroy unlock]
      before_action :resource_create_object, only: %i[create]

      def show; end

      def create
        respond_to do |format|
          if @user.persisted?
            current_site.user_sites
                        .create(user: @user, role: resource_params.fetch(:role, UserSite::ROLE_DEFAULT))
            # TODO: Generate starter content
            format.json { render :create, status: :created }
          else
            format.json { render json: json_unprocessable(@user), status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @user.destroy

        respond_to do |format|
          format.json { head :no_content }
        end
      end

      def unlock
        @user.unlock_access!

        respond_to do |format|
          format.json { render :show, status: :accepted }
        end
      end

      protected

      def resource_object
        user_id = params.fetch(:id, '')

        @user = current_site.users.where.not(id: current_user.id).find_by!(username: user_id)
      rescue ActiveRecord::RecordNotFound
        render json: json_not_found(controller_name), status: :not_found
      end

      def resource_create_object
        create_resource_params = resource_params.except(:role)

        @user = User.invite!(create_resource_params, current_user)
      end

      def permitted_attributes
        %i[email first_name last_name role username]
      end

      def resource_params
        params.permit(permitted_attributes)
      end
    end
  end
end
