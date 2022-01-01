# frozen_string_literal: true

class Collection < ApplicationRecord
  include DeleteConcern
  include PublishConcern

  belongs_to :site

  has_many :collection_entries, -> { order(position: :asc) }, inverse_of: :collection, dependent: :destroy
  has_many :collection_fields, -> { order(position: :asc) }, inverse_of: :collection, dependent: :destroy

  accepts_nested_attributes_for :collection_fields, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { scope: :site_id }
end
