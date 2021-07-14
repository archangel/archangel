# frozen_string_literal: true

module Manage
  class UsersController < ManageController
    include Controllers::PaginationConcern

    before_action :set_users, only: %i[index]
    before_action :set_user, only: %i[show edit update destroy reinvite unlock]
    before_action :set_new_user, only: %i[new]
    before_action :set_create_user, only: %i[create]

    def index; end

    def show; end

    def new; end

    def create
      respond_to do |format|
        if @user.persisted?
          current_site.user_sites
                      .create(user: @user, role: resource_params.fetch(:role, UserSite::ROLE_DEFAULT))

          format.html { redirect_to manage_users_path, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: manage_user_path(@user) }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit; end

    def update
      respond_to do |format|
        managed_resource_params = resource_params.except(:role)

        if @user.update_without_password(managed_resource_params)
          current_site.user_sites
                      .find_by(user: params[:id])
                      .update(role: resource_params.fetch(:role, UserSite::ROLE_DEFAULT))

          format.html { redirect_to manage_user_path(@user), notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: manage_user_path(@user) }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @user.destroy

      respond_to do |format|
        format.html { redirect_to manage_users_path, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def reinvite
      @user.deliver_invitation

      respond_to do |format|
        format.html { redirect_to manage_user_path(@user), notice: 'User was successfully reinvited.' }
        format.json { render :show, status: :ok, location: manage_user_path(@user) }
      end
    end

    def unlock
      @user.unlock_access!

      respond_to do |format|
        format.html { redirect_to manage_user_path(@user), notice: 'User was successfully unlocked.' }
        format.json { render :show, status: :ok, location: manage_user_path(@user) }
      end
    end

    protected

    def permitted_attributes
      %i[email first_name last_name role username]
    end

    def set_users
      @users = current_site.users.order(username: :asc).where.not(id: current_user.id).page(page_num).per(per_page)

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

    def resource_params
      params.require(:user).permit(permitted_attributes)
    end
  end
end
