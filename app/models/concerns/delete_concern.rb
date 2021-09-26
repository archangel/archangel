# frozen_string_literal: true

module DeleteConcern
  extend ActiveSupport::Concern

  included do
    include Discard::Model
  end
end
