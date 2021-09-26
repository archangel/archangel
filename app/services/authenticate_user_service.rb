# frozen_string_literal: true

class AuthenticateUserService < ApplicationService
  def initialize(email, password)
    super

    @email = email
    @password = password
  end

  private

  attr_reader :email, :password

  def user
    @user ||= User.find_by(email: email)
  end

  def password_valid?
    user&.valid_password?(password)
  end

  def payload
    if password_valid?
      @result = user.auth_token
    else
      errors.add(:base, I18n.t('api.unauthorized.invalid'))
    end
  end
end
