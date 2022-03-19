# frozen_string_literal: true

# User model
class User < ApplicationRecord
  include Models::PaperTrailConcern

  devise :confirmable, :database_authenticatable, :invitable, :lockable, :recoverable, :rememberable, :timeoutable,
         :trackable, :validatable # :registerable

  scope :sort_on_username, ->(direction) { order(username: direction) }

  has_secure_token :auth_token

  has_one :user_site, dependent: :destroy
  has_many :sites, through: :user_site
  has_many :user_sites, dependent: :destroy
  has_many :versions, class_name: 'PaperTrail::Version', foreign_key: :item_id, dependent: :destroy

  delegate :role, to: :user_site, allow_nil: true

  validates :email, presence: true, email: true, uniqueness: true
  validates :first_name, presence: true
  validates :username, presence: true, slug: true, uniqueness: true

  # Full name
  #
  # First name and last name to make the full name
  #
  # @return [String] the full name of the user
  def name
    [first_name, last_name].join(' ')
  end

  # Locked
  #
  # Check if User is locked from logging in from too many failed login attempts
  #
  # @return [Boolean] if locked
  def locked?
    locked_at.present?
  end

  # Invitation pending
  #
  # Check if User has accepted the invitation to join
  #
  # @return [Boolean] if invitation pending
  def invitation_pending?
    invitation_accepted_at.blank?
  end
end
