# frozen_string_literal: true

module Manage
  class DashboardsController < ManageController
    def show
      authorize :dashboard
    end
  end
end
