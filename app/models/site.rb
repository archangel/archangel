# frozen_string_literal: true

class Site < ApplicationRecord
  before_create :create_token

  has_many :metatags, as: :metatagable, dependent: :destroy
  has_many :pages, dependent: :destroy

  has_many :user_sites, dependent: :destroy
  has_many :users, through: :user_sites

  accepts_nested_attributes_for :metatags, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true, uniqueness: true

  private

  def create_token
    return if token.present?

    self.token = generate_token
  end

  def generate_token
    SecureRandom.urlsafe_base64
  end
end
