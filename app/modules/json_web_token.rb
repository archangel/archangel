# frozen_string_literal: true

class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, Rails.application.secret_key_base, 'HS256')
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256').first
  end
end
