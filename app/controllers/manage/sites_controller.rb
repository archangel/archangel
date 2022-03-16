# frozen_string_literal: true

# Manage (admin)
module Manage
  # Site
  class SitesController < ManageController
    before_action :set_site, only: %i[show edit update]

    # Show resource
    #
    # @example Show resource
    #   GET /manage/site
    def show; end

    # Edit resource
    #
    # @example Edit resource
    #   GET /manage/site/edit
    def edit; end

    # Update resource
    #
    # @example Update resource
    #   PUT /manage/site
    def update
      respond_to do |format|
        if @site.update(site_params)
          format.html { redirect_to manage_site_path, notice: I18n.t('flash.sites.update.success') }
          format.json { render :show, status: :ok, location: manage_site_path }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @site.errors, status: :unprocessable_entity }
        end
      end
    end

    # Switch site
    #
    # @example Switch site
    #   POST /manage/sites/{id}/switch
    def switch
      authorize %i[site]

      resource_id = params.fetch(:id)

      cookies[:_archangel_site] = { value: resource_id, expires: nil }

      redirect_to manage_root_path, status: :moved_permanently, flash: { success: I18n.t('flash.sites.switch.success') }
    end

    protected

    def permitted_attributes
      [
        :name, :subdomain,
        :format_date, :format_datetime, :format_time, :format_js_date, :format_js_datetime, :format_js_time,
        :regenerate_auth_token_on_login, :regenerate_auth_token_on_logout,
        { stores_attributes: %i[id _destroy key value] }
      ]
    end

    def set_site
      authorize %i[site]

      @site = current_site
    end

    def site_params
      params.require(:site).permit(permitted_attributes)
    end
  end
end
