# frozen_string_literal: true

# Content model
class Content < ApplicationRecord
  include DeleteConcern
  include PublishConcern

  scope :sort_on_name, ->(direction) { order(name: direction) }
  scope :sort_on_slug, ->(direction) { order(slug: direction) }

  belongs_to :site

  has_many :stores, as: :storable, dependent: :destroy

  accepts_nested_attributes_for :stores, reject_if: :all_blank, allow_destroy: true

  validates :slug, presence: true, uniqueness: { scope: :site_id }
  validates :name, presence: true
end
