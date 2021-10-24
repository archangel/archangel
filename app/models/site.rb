# frozen_string_literal: true

class Site < ApplicationRecord
  include DeleteConcern

  typed_store :settings, coder: ActiveRecord::TypedStore::IdentityCoder do |s|
    s.string :format_datetime, blank: false, default: '%B %-d, %Y @ %I:%M:%S %p'
  end

  has_many :collections, dependent: :destroy
  has_many :contents, dependent: :destroy
  has_many :stores, as: :storable, dependent: :destroy

  has_many :user_sites, dependent: :destroy
  has_many :users, through: :user_sites

  accepts_nested_attributes_for :stores, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true, uniqueness: true
  validates :subdomain, presence: true, uniqueness: true
end
