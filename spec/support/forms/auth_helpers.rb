# frozen_string_literal: true

def fill_in_and_submit_login_form_with(fields = {})
  email = fields.fetch(:email, nil)
  password = fields.fetch(:password, nil)
  remember_me = fields.fetch(:remember_me, nil)

  fill_in 'Email', with: email if email.present?
  fill_in 'Password', with: password if password.present?
  (remember_me ? check('Remember me') : uncheck('Remember me')) if [true, false].include?(remember_me)

  click_button 'Log in'
end

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def fill_in_and_submit_register_form_with(fields = {})
  email = fields.fetch(:email, nil)
  first_name = fields.fetch(:first_name, nil)
  last_name = fields.fetch(:last_name, nil)
  username = fields.fetch(:username, nil)
  password = fields.fetch(:password, nil)
  password_confirmation = fields.fetch(:password_confirmation, password)

  fill_in 'Email', with: email if email.present?
  fill_in 'First Name', with: first_name if first_name.present?
  fill_in 'Last Name', with: last_name if last_name.present?
  fill_in 'Username', with: username if username.present?
  fill_in 'Password', with: password, match: :prefer_exact if password.present?
  fill_in 'Password Confirmation', with: password_confirmation if password_confirmation.present?

  click_button 'Sign up'
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def fill_in_and_submit_invitation_form_with(fields = {})
  first_name = fields.fetch(:first_name, nil)
  last_name = fields.fetch(:last_name, nil)
  username = fields.fetch(:username, nil)
  password = fields.fetch(:password, nil)
  password_confirmation = fields.fetch(:password_confirmation, password)

  fill_in 'First Name', with: first_name if first_name.present?
  fill_in 'Last Name', with: last_name if last_name.present?
  fill_in 'Username', with: username if username.present?
  fill_in 'Password', with: password, match: :prefer_exact if password.present?
  fill_in 'Password Confirmation', with: password_confirmation if password_confirmation.present?

  click_button 'Set my password'
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength
