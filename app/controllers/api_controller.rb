# frozen_string_literal: true

# Base API controller
class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_default_format

  private

  def set_default_format
    request.format = :json
  end
end
