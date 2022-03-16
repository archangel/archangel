# frozen_string_literal: true

# Auth
module Auth
  # Devise registration
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

    protected

    def after_sign_up_path_for(resource)
      stored_location_for(resource) || manage_root_path
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name username])
    end
  end
end
