# frozen_string_literal: true

# API
module Api
  # API v1
  module V1
    # Roots API v1
    class RootsController < V1Controller
      skip_before_action :authenticate_user!

      # Show resource
      #
      # @example Show resource
      #   GET /api/v1
      def show; end
    end
  end
end
