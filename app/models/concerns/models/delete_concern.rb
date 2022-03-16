# frozen_string_literal: true

# Model concern
module Models
  # Delete concern
  #
  # Example
  #   class Example < ApplicationRecord
  #     include Models::DeleteConcern
  #   end
  module DeleteConcern
    extend ActiveSupport::Concern

    included do
      include Discard::Model
    end
  end
end
