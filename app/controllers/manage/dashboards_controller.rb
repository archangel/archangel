# frozen_string_literal: true

# Manage (admin)
module Manage
  # Dashboard
  class DashboardsController < ManageController
    # Show resource
    #
    # @example Show resource
    #   GET /manage
    def show
      authorize :dashboard
    end
  end
end
