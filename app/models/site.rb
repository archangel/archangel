# frozen_string_literal: true

class Site < ApplicationRecord
  include DeleteConcern

  typed_store :settings, coder: ActiveRecord::TypedStore::IdentityCoder do |s|
    # Date formats for Ruby
    s.string :format_date, blank: false, default: '%B %-d, %Y'
    s.string :format_datetime, blank: false, default: '%B %-d, %Y @ %I:%M %p'
    s.string :format_time, blank: false, default: '%I:%M %p'

    # Date formats for Javascript (using Moment.js formatting)
    s.string :format_js_date, blank: false, default: 'MMMM Do YYYY'
    s.string :format_js_datetime, blank: false, default: 'MMMM Do YYYY @ h:mm a'
    s.string :format_js_time, blank: false, default: 'h:mm a'

    # When to auto regenerate auth_token
    s.boolean :regenerate_auth_token_on_login, default: false
    s.boolean :regenerate_auth_token_on_logout, default: false
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
