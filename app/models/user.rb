# frozen_string_literal: true

class User < ApplicationRecord
  include AuthTokenConcern

  devise :confirmable, :database_authenticatable, :invitable, :lockable, :recoverable, :rememberable, :timeoutable,
         :trackable, :validatable # :registerable

  has_one :user_site, dependent: :destroy
  has_many :sites, through: :user_site
  has_many :user_sites, dependent: :destroy

  delegate :role, to: :user_site, allow_nil: true

  validates :email, presence: true, email: true, uniqueness: true
  validates :first_name, presence: true
  validates :username, presence: true, slug: true, uniqueness: true

  def name
    [first_name, last_name].join(' ')
  end

  def locked?
    locked_at.present?
  end

  def invitation_pending?
    invitation_accepted_at.blank?
  end
end
