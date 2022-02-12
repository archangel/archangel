# frozen_string_literal: true

class ManageController < ApplicationController
  include Pundit::Authorization
  include Controllers::ActionConcern

  rescue_from AbstractController::ActionNotFound,
              ActiveRecord::RecordNotFound,
              ActionController::RoutingError, with: :render_error_not_found
  rescue_from Pundit::NotAuthorizedError, with: :render_error_unauthorized

  before_action :authenticate_user!
  after_action :verify_authorized

  layout 'manage'

  protected

  def render_error_not_found(exception = nil)
    render_error('manage/errors/not_found', :not_found, exception)
  end

  def render_error_unauthorized(exception = nil)
    render_error('manage/errors/unauthorized', :unauthorized, exception)
  end

  def render_error(path, status, _exception = nil)
    respond_to do |format|
      format.html { render(template: path, status: status, layout: 'manage') }
      format.json { render(template: path, status: status, layout: false) }
    end
  end
end
