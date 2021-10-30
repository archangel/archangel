# frozen_string_literal: true

class User < ApplicationRecord
  devise :confirmable, :database_authenticatable, :invitable, :lockable, :recoverable, :registerable, :rememberable,
         :timeoutable, :trackable, :validatable

  before_create :create_auth_token

  has_one :user_site, dependent: :destroy
  has_many :sites, through: :user_site

  delegate :role, to: :user_site, allow_nil: true

  validates :email, presence: true, email: true, uniqueness: true
  validates :first_name, presence: true
  validates :username, presence: true, slug: true, uniqueness: true

  def name
    [first_name, last_name].join(' ')
  end

  private

  def create_auth_token
    return if auth_token.present?

    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    SecureRandom.hex(24)
  end
end
