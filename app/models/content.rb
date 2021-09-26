# frozen_string_literal: true

class Content < ApplicationRecord
  include DeleteConcern

  belongs_to :site

  has_many :stores, as: :storable, dependent: :destroy

  accepts_nested_attributes_for :stores, reject_if: :all_blank, allow_destroy: true

  validates :slug, presence: true, uniqueness: { scope: :site_id }
  validates :name, presence: true
end
