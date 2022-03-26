# frozen_string_literal: true

# API
module Api
  # API v1
  module V1
    # Users API v1
    class UsersController < V1Controller
      include Toller
      include Controllers::Api::V1::PaginationConcern
      include Controllers::Api::V1::PaperTrailConcern

      sort_on :username, type: :scope, scope_name: :sort_on_username, default: true

      before_action :resource_collection, only: %i[index]
      before_action :resource_object, only: %i[show update destroy unlock]
      before_action :resource_create_object, only: %i[create]

      # All resources
      #
      # @todo Filter; include confirmed
      # @todo Query; first name, last name, username, email, confirmed
      #
      # @example All resources
      #   GET /api/v1/users
      #
      # @example All resources sorted by username
      #   GET /api/v1/users?sort=username
      #   GET /api/v1/users?sort=-username
      #
      # @example All resources paginated
      #   GET /api/v1/users?per=100
      #   GET /api/v1/users?page=2&per=12
      def index; end

      # Show resource
      #
      # @todo Filter; include confirmed
      #
      # @example Show resource
      #   GET /api/v1/users/{username}
      def show; end

      # Create resource
      #
      # @example Create resource
      #   POST /api/v1/users
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

      # Update resource
      #
      # @example Update resource
      #   PUT /api/v1/users/{username}
      def update
        respond_to do |format|
          if @user.update(resource_params)
            format.json { render :update, status: :accepted }
          else
            format.json { render json: json_unprocessable(@user), status: :unprocessable_entity }
          end
        end
      end

      # Destroy resource
      #
      # @example Destroy resource
      #   DELETE /api/v1/users/{username}
      def destroy
        @user.destroy

        respond_to do |format|
          format.json { head :no_content }
        end
      end

      # Unlock resource
      #
      # @example Unlock resource
      #   POST /api/v1/users/{username}/unlock
      def unlock
        @user.unlock_access!

        respond_to do |format|
          format.json { render :show, status: :accepted }
        end
      end

      protected

      def resource_collection
        @users = retrieve(
          current_site.users.where.not(id: current_user.id)
        ).page(page_num).per(per_page)

        authorize :user
      end

      def resource_object
        user_id = params.fetch(:id, '')

        @user = current_site.users.where.not(id: current_user.id).find_by!(username: user_id)

        authorize :user
      rescue ActiveRecord::RecordNotFound
        render json: json_not_found(controller_name), status: :not_found
      end

      def resource_create_object
        create_resource_params = resource_params.except(:role)

        @user = User.invite!(create_resource_params, current_user)

        authorize :user
      end

      def resource_params
        permitted_attributes = policy(:user).permitted_attributes

        params.permit(permitted_attributes)
      end
    end
  end
end
