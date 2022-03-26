# frozen_string_literal: true

# Content model
class Content < ApplicationRecord
  include Models::DeleteConcern
  include Models::PublishConcern

  has_paper_trail ignore: %i[updated_at]

  scope :sort_on_name, ->(direction) { order(name: direction) }
  scope :sort_on_slug, ->(direction) { order(slug: direction) }

  belongs_to :site

  has_many :stores, as: :storable, dependent: :destroy
  has_many :versions, -> { where(item_type: 'Content').order(created_at: :desc) },
           foreign_key: :item_id, inverse_of: :content, dependent: :destroy

  accepts_nested_attributes_for :stores, reject_if: :all_blank, allow_destroy: true

  validates :slug, presence: true, uniqueness: { scope: :site_id }
  validates :name, presence: true
end
