# frozen_string_literal: true

class ApiController < ApplicationController
  include Controllers::CurrentSiteConcern

  skip_before_action :verify_authenticity_token
  before_action :set_default_format
  after_action :set_version_header

  protected

  def identify_current_site
    headers.fetch('X-Archangel-Site', nil)
  end

  def set_version_header
    response.headers['X-Archangel-Api-Version'] = 'V1'
  end

  private

  def set_default_format
    request.format = :json
  end
end
