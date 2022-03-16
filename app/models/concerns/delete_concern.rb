# frozen_string_literal: true

# Delete concern
module DeleteConcern
  extend ActiveSupport::Concern

  included do
    include Discard::Model
  end
end
