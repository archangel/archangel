# frozen_string_literal: true

##
# Fill in Profile form
#
# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def fill_in_profile_form_with(fields = {})
  first_name = fields.fetch(:first_name, nil)
  last_name = fields.fetch(:last_name, nil)
  username = fields.fetch(:username, nil)
  email = fields.fetch(:email, nil)
  password = fields.fetch(:password, nil)
  password_confirmation = fields.fetch(:password_confirmation, password)

  fill_in 'First Name', with: first_name if first_name.present?
  fill_in 'Last Name', with: last_name if last_name.present?
  fill_in 'Username', with: username if username.present?
  fill_in 'Email', with: email if email.present?
  fill_in 'Password', with: password, match: :prefer_exact if password.present?
  fill_in 'Password Confirmation', with: password_confirmation if password_confirmation.present?
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

def fill_in_and_update_profile_form_with(fields = {})
  fill_in_profile_form_with(fields)

  submit_update_profile_form
end

def submit_update_profile_form
  click_button 'Update Profile'
end
