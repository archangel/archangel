# frozen_string_literal: true

module Auth
  class SessionsController < Devise::SessionsController
    ##
    # Remove double flash message
    #
    # Devise sends a success (notice) message when logging in. Responders sends a success (success) message when
    # logging in. Only one needs to be sent.
    #
    def create
      super

      flash.delete(:success)
    end

    protected

    def after_sign_out_path_for(_resource_or_scope)
      manage_root_path
    end
  end
end
