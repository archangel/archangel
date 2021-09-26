# frozen_string_literal: true

class DecodeAuthenticationService < ApplicationService
  def initialize(headers)
    super

    @headers = headers
    @user = nil
  end

  private

  attr_reader :headers

  def payload
    return unless token_present?

    @result = user if user
  end

  def user
    @user ||= User.find_by(auth_token: token_contents)
    @user || (errors.add(:token, I18n.t('api.unauthorized.token_invalid')) && nil)
  end

  def token_present?
    token.present? && token_contents.present?
  end

  def authorization_header
    headers['Authorization']
  end

  def token_contents
    @token_contents ||= token
  end

  def token
    return authorization_header.split.last if authorization_header.present?

    errors.add(:token, I18n.t('api.unauthorized.token_missing'))
    nil
  end
end
