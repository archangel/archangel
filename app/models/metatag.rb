# frozen_string_literal: true

class Metatag < ApplicationRecord
  belongs_to :metatagable, polymorphic: true

  validates :name, presence: true, uniqueness: { scope: %i[metatagable_type metatagable_id] }
  validates :content, allow_blank: true, presence: true
end
