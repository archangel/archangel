# frozen_string_literal: true

module Manage
  class ContentsController < ManageController
    include Controllers::PaginationConcern

    before_action :set_contents, only: %i[index]
    before_action :set_content, only: %i[show edit update destroy]
    before_action :set_new_content, only: %i[new]
    before_action :set_create_content, only: %i[create]
    before_action :set_restore_content, only: %i[restore]

    def index; end

    def show; end

    def new; end

    def create
      respond_to do |format|
        if @content.save
          format.html { redirect_to manage_content_path(@content), notice: I18n.t('flash.contents.create.success') }
          format.json { render :show, status: :created, location: manage_content_path(@content) }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @content.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if @content.update(resource_params)
          format.html { redirect_to manage_content_path(@content), notice: I18n.t('flash.contents.update.success') }
          format.json { render :show, status: :ok, location: manage_content_path(@content) }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @content.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @content.discard

      respond_to do |format|
        format.html { redirect_to manage_contents_path, notice: I18n.t('flash.contents.destroy.success') }
        format.json { head :no_content }
      end
    end

    def restore
      @content.undiscard

      respond_to do |format|
        format.html { redirect_to manage_contents_path, notice: I18n.t('flash.contents.restore.success') }
        format.json { head :no_content }
      end
    end

    protected

    def permitted_attributes
      [
        :body, :name, :published_at, :slug,
        { stores_attributes: %i[id _destroy key value] }
      ]
    end

    def set_contents
      @contents = current_site.contents.with_discarded.order(name: :asc).page(page_num).per(per_page)

      authorize @contents
    end

    def set_content
      resource_id = params.fetch(:id, nil)

      @content = current_site.contents.with_discarded.find(resource_id)

      authorize @content
    end

    def set_new_content
      @content = current_site.contents.new

      authorize @content
    end

    def set_create_content
      @content = current_site.contents.new(resource_params)

      authorize @content
    end

    def set_restore_content
      resource_id = params.fetch(:id, nil)

      @content = current_site.contents.with_discarded.find(resource_id)

      authorize @content
    end

    def resource_params
      params.require(:content).permit(permitted_attributes)
    end
  end
end
