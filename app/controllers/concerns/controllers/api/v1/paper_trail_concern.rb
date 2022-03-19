# frozen_string_literal: true

# Controller concern
module Controllers
  # Controller API concern
  module Api
    # Controller API v1 concern
    module V1
      # Track changes with paper_trail
      module PaperTrailConcern
        extend ActiveSupport::Concern

        included do
          before_action :set_paper_trail_whodunnit
        end

        def info_for_paper_trail
          { origin: 'api', ip: request.remote_ip, user_agent: request.user_agent }
        end
      end
    end
  end
end
