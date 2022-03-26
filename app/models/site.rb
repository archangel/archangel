# frozen_string_literal: true

# Site model
class Site < ApplicationRecord
  include Models::DeleteConcern

  FORMAT_DATE_JS_DEFAULT = 'MMMM Do YYYY'
  FORMAT_DATETIME_JS_DEFAULT = 'MMMM Do YYYY @ h:mm a'
  FORMAT_TIME_JS_DEFAULT = 'h:mm a'
  FORMAT_DATE_RUBY_DEFAULT = '%B %-d, %Y'
  FORMAT_DATETIME_RUBY_DEFAULT = '%B %-d, %Y @ %I:%M %p'
  FORMAT_TIME_RUBY_DEFAULT = '%I:%M %p'

  has_paper_trail ignore: %i[updated_at]

  typed_store :settings, coder: ActiveRecord::TypedStore::IdentityCoder do |s|
    # Date formats for Ruby
    s.string :format_date, blank: false, default: FORMAT_DATE_RUBY_DEFAULT
    s.string :format_datetime, blank: false, default: FORMAT_DATETIME_RUBY_DEFAULT
    s.string :format_time, blank: false, default: FORMAT_TIME_RUBY_DEFAULT

    # Date formats for Javascript (using Moment.js formatting)
    s.string :format_js_date, blank: false, default: FORMAT_DATE_JS_DEFAULT
    s.string :format_js_datetime, blank: false, default: FORMAT_DATETIME_JS_DEFAULT
    s.string :format_js_time, blank: false, default: FORMAT_TIME_JS_DEFAULT

    # When to auto regenerate auth_token
    s.boolean :regenerate_auth_token_on_login, default: false
    s.boolean :regenerate_auth_token_on_logout, default: false
  end

  has_many :collections, dependent: :destroy
  has_many :contents, dependent: :destroy
  has_many :stores, as: :storable, dependent: :destroy
  has_many :user_sites, dependent: :destroy
  has_many :users, through: :user_sites
  has_many :versions, -> { where(item_type: 'Site').order(created_at: :desc) },
           foreign_key: :item_id, inverse_of: :site, dependent: :destroy

  accepts_nested_attributes_for :stores, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true, uniqueness: true
  validates :subdomain, presence: true, uniqueness: true
end
