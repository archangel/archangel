# frozen_string_literal: true

module AuthTokenConcern
  extend ActiveSupport::Concern

  included do
    before_save :ensure_auth_token
  end

  protected

  def ensure_auth_token
    return if auth_token.present?

    self.auth_token = generate_auth_token
  end

  private

  def generate_auth_token
    loop do
      token = SecureRandom.base58(24)
      break token unless self.class.where(auth_token: token).first
    end
  end
end
