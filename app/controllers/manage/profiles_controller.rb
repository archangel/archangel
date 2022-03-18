# frozen_string_literal: true

# Manage (admin)
module Manage
  # Profile
  class ProfilesController < ManageController
    before_action :set_profile, only: %i[show edit update retoken]

    # Show resource
    #
    # @example Show resource
    #   GET /manage/profile
    def show; end

    # Edit resource
    #
    # @example Edit resource
    #   GET /manage/profile/edit
    def edit; end

    # Update resource
    #
    # @example Update resource
    #   PUT /manage/profile
    def update
      update_resource_params = resource_params
      update_resource_params = update_resource_params.except(:password, :password_confirmation) unless needs_password?

      respond_to do |format|
        if @profile.update(update_resource_params)
          bypass_sign_in(@profile)

          format.html { redirect_to manage_profile_path, notice: I18n.t('flash.profiles.update.success') }
          format.json { render :show, status: :ok, location: manage_profile_path }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @profile.errors, status: :unprocessable_entity }
        end
      end
    end

    # Retoken resource
    #
    # @example Retoken resource
    #   POST /manage/profile/retoken
    def retoken
      @profile.regenerate_auth_token

      respond_to do |format|
        format.html { redirect_to manage_profile_path, notice: I18n.t('flash.profiles.retoken.success') }
        format.json { render :show, status: :ok, location: manage_profile_path }
      end
    end

    protected

    def set_profile
      @profile = current_user

      authorize :profile
    end

    def resource_params
      permitted_attributes = policy(:profile).permitted_attributes

      params.require(:profile).permit(permitted_attributes)
    end

    private

    def needs_password?
      resource_params.fetch(:password, nil).present?
    end
  end
end
