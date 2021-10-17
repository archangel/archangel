# frozen_string_literal: true

class Store < ApplicationRecord
  belongs_to :storable, polymorphic: true

  validates :key, presence: true, uniqueness: { scope: %i[storable_type storable_id] }, camel_case: true
  validates :value, allow_blank: true, presence: true
end
