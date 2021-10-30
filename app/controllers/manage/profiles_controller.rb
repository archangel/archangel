# frozen_string_literal: true

module Manage
  class ProfilesController < ManageController
    before_action :set_profile, only: %i[show edit update]

    def show; end

    def edit; end

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

    protected

    def permitted_attributes
      %i[email first_name last_name password password_confirmation username]
    end

    def set_profile
      @profile = current_user

      authorize :profile
    end

    def resource_params
      params.require(:profile).permit(permitted_attributes)
    end

    private

    def needs_password?
      resource_params.fetch(:password, nil).present?
    end
  end
end
