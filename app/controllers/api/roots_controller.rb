# frozen_string_literal: true

module Api
  class RootsController < V1Controller
    skip_before_action :authenticate_user!

    def show; end
  end
end
