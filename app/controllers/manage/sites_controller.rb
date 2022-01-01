# frozen_string_literal: true

module Manage
  class SitesController < ManageController
    before_action :set_site, only: %i[show edit update]

    def show; end

    def edit; end

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

    protected

    def permitted_attributes
      [
        :name, :subdomain,
        :format_date, :format_datetime, :format_time, :format_js_date, :format_js_datetime, :format_js_time,
        { stores_attributes: %i[id _destroy key value] }
      ]
    end

    def set_site
      @site = current_site

      authorize @site
    end

    def site_params
      params.require(:site).permit(permitted_attributes)
    end
  end
end
