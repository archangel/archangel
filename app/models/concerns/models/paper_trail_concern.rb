# frozen_string_literal: true

# Model concern
module Models
  # Track changes with paper_trail
  module PaperTrailConcern
    extend ActiveSupport::Concern

    included do
      has_paper_trail versions: { scope: -> { order(created_at: :desc, id: :desc) } },
                      ignore: %i[updated_at]
    end
  end
end
