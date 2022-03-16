# frozen_string_literal: true

# Manage (admin)
module Manage
  # User
  class UsersController < ManageController
    include Controllers::PaginationConcern

    before_action :set_users, only: %i[index]
    before_action :set_user, only: %i[show edit update reinvite retoken unlock]
    before_action :set_new_user, only: %i[new]
    before_action :set_create_user, only: %i[create]
    before_action :set_destroy_user, only: %i[destroy]

    # All resources
    #
    # @example All resources
    #   GET /manage/users
    def index; end

    # Show resource
    #
    # @example Show resource
    #   GET /manage/users/{id}
    def show; end

    # New resource
    #
    # @example New resource
    #   GET /manage/users/new
    def new; end

    # Create resource
    #
    # @example Create resource
    #   POST /manage/users
    def create
      respond_to do |format|
        if @user.persisted?
          current_site.user_sites
                      .create(user: @user, role: resource_params.fetch(:role, UserSite::ROLE_DEFAULT))

          format.html { redirect_to manage_users_path, notice: I18n.t('flash.users.create.success') }
          format.json { render :show, status: :created, location: manage_user_path(@user) }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # Edit resource
    #
    # @example Edit resource
    #   GET /manage/users/{id}/edit
    def edit; end

    # Update resource
    #
    # @example Update resource
    #   PUT /manage/users/{id}
    def update
      respond_to do |format|
        managed_resource_params = resource_params.except(:role)

        if @user.update_without_password(managed_resource_params)
          current_site.user_sites
                      .find_by(user: params[:id])
                      .update(role: resource_params.fetch(:role, UserSite::ROLE_DEFAULT))

          format.html { redirect_to manage_user_path(@user), notice: I18n.t('flash.users.update.success') }
          format.json { render :show, status: :ok, location: manage_user_path(@user) }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # Destroy resource
    #
    # @example Destroy resource
    #   DELETE /manage/users/{id}
    def destroy
      @user_site.destroy

      respond_to do |format|
        format.html { redirect_to manage_users_path, notice: I18n.t('flash.users.destroy.success') }
        format.json { head :no_content }
      end
    end

    # Reinvite resource
    #
    # @example Reinvite resource
    #   GET /manage/users/{id}/reinvite
    def reinvite
      @user.deliver_invitation

      respond_to do |format|
        format.html { redirect_to manage_user_path(@user), notice: I18n.t('flash.users.reinvite.success') }
        format.json { render :show, status: :ok, location: manage_user_path(@user) }
      end
    end

    # Retoken resource
    #
    # @example Retoken resource
    #   POST /manage/users/{id}/retoken
    def retoken
      @user.regenerate_auth_token

      respond_to do |format|
        format.html { redirect_to manage_user_path(@user), notice: I18n.t('flash.users.retoken.success') }
        format.json { render :show, status: :ok, location: manage_user_path(@user) }
      end
    end

    # Unlock resource
    #
    # @example Unlock resource
    #   GET /manage/users/{id}/unlock
    def unlock
      @user.unlock_access!

      respond_to do |format|
        format.html { redirect_to manage_user_path(@user), notice: I18n.t('flash.users.unlock.success') }
        format.json { render :show, status: :ok, location: manage_user_path(@user) }
      end
    end

    protected

    def permitted_attributes
      %i[email first_name last_name role username]
    end

    def set_users
      @users = current_site.users
                           .includes(%i[user_site])
                           .order(username: :asc)
                           .where.not(id: current_user.id)
                           .page(page_num).per(per_page)

      authorize @users
    end

    def set_user
      resource_id = params.fetch(:id, nil)

      @user = current_site.users.where.not(id: current_user.id).find(resource_id)

      authorize @user
    end

    def set_new_user
      @user = current_site.users.new

      authorize @user
    end

    def set_create_user
      managed_resource_params = resource_params.except(:role)

      @user = User.invite!(managed_resource_params, current_user)

      authorize @user
    end

    def set_destroy_user
      resource_id = params.fetch(:id, nil)

      @user_site = current_site.user_sites
                               .where.not(user_id: current_user.id)
                               .where(site_id: current_site.id, user_id: resource_id)
                               .first

      authorize @user_site
    end

    def resource_params
      params.require(:user).permit(permitted_attributes)
    end
  end
end
