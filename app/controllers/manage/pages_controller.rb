# frozen_string_literal: true

module Manage
  class PagesController < ManageController
    include Controllers::PaginationConcern

    before_action :set_pages, only: %i[index]
    before_action :set_page, only: %i[show edit update destroy]
    before_action :set_new_page, only: %i[new]
    before_action :set_create_page, only: %i[create]

    def index; end

    def show; end

    def new; end

    def create
      respond_to do |format|
        if @page.save
          format.html { redirect_to manage_page_path(@page), notice: 'Page was successfully created.' }
          format.json { render :show, status: :created, location: manage_page_path(@page) }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if @page.update(resource_params)
          format.html { redirect_to manage_page_path(@page), notice: 'Page was successfully updated.' }
          format.json { render :show, status: :ok, location: manage_page_path(@page) }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @page.discard

      respond_to do |format|
        format.html { redirect_to manage_pages_path, notice: 'Page was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    protected

    def permitted_attributes
      [
        :published_at, :site_id, :slug, :title,
        { metatags_attributes: %i[id _destroy name content] }
      ]
    end

    def set_pages
      @pages = current_site.pages.order(title: :asc).page(page_num).per(per_page)

      authorize @pages
    end

    def set_page
      @page = current_site.pages.find(params[:id])

      authorize @page
    end

    def set_new_page
      @page = current_site.pages.new

      authorize @page
    end

    def set_create_page
      @page = current_site.pages.new(resource_params)

      authorize @page
    end

    def resource_params
      params.require(:page).permit(permitted_attributes)
    end
  end
end
