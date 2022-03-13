# frozen_string_literal: true

# Base Auth controller
class AuthController < ApplicationController
  layout 'auth'

  protected

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || manage_root_path
  end
end
