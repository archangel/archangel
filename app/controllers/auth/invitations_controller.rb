# frozen_string_literal: true

# Auth
module Auth
  # Devise invitation
  class InvitationsController < Devise::InvitationsController
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def after_accept_path_for(resource)
      stored_location_for(resource) || manage_root_path
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation, keys: %i[first_name last_name username])
    end
  end
end
