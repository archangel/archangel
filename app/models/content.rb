# frozen_string_literal: true

# Content model
class Content < ApplicationRecord
  include Models::DeleteConcern
  include Models::PublishConcern
  include Models::PaperTrailConcern

  scope :sort_on_name, ->(direction) { order(name: direction) }
  scope :sort_on_slug, ->(direction) { order(slug: direction) }

  belongs_to :site

  has_many :stores, as: :storable, dependent: :destroy
  has_many :versions, class_name: 'PaperTrail::Version', foreign_key: :item_id, dependent: :destroy

  accepts_nested_attributes_for :stores, reject_if: :all_blank, allow_destroy: true

  validates :slug, presence: true, uniqueness: { scope: :site_id }
  validates :name, presence: true
end
