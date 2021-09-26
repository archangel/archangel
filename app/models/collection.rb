# frozen_string_literal: true

class Collection < ApplicationRecord
  include DeleteConcern

  belongs_to :site

  has_many :collection_entries, -> { order(position: :asc) }, inverse_of: :collection, dependent: :destroy
  has_many :collection_fields, -> { order(position: :asc) }, inverse_of: :collection, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { scope: :site_id }
end
