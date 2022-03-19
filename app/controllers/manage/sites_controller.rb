# frozen_string_literal: true

# Manage (admin)
module Manage
  # Site
  class SitesController < ManageController
    include Controllers::PaperTrailConcern

    before_action :set_site, only: %i[show edit update]
    before_action :set_history_site, only: %i[history]

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

    # History resource
    #
    # @example History resource
    #   GET /manage/site/history
    def history; end

    # Switch site
    #
    # @example Switch site
    #   POST /manage/sites/{id}/switch
    def switch
      authorize :site

      resource_id = params.fetch(:id)

      cookies[:_archangel_site] = { value: resource_id, expires: nil }

      redirect_to manage_root_path, status: :moved_permanently, flash: { success: I18n.t('flash.sites.switch.success') }
    end

    protected

    def set_site
      @site = current_site

      authorize :site
    end

    def set_history_site
      @site = current_site
      @versions = @site.versions.includes(%i[user])

      authorize :site
    end

    def site_params
      permitted_attributes = policy(:site).permitted_attributes

      params.require(:site).permit(permitted_attributes)
    end
  end
end
