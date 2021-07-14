# frozen_string_literal: true

class Page < ApplicationRecord
  include Discard::Model

  belongs_to :site

  has_many :metatags, as: :metatagable, dependent: :destroy

  accepts_nested_attributes_for :metatags, reject_if: :all_blank, allow_destroy: true

  validates :slug, presence: true, uniqueness: { scope: :site_id }
  validates :title, presence: true
end
