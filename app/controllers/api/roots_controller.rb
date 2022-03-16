# frozen_string_literal: true

# API
module Api
  # Roots API
  class RootsController < V1Controller
    skip_before_action :authenticate_user!

    # Show resource
    #
    # @example Show resource
    #   POST /api
    def show; end
  end
end
