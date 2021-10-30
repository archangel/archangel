# frozen_string_literal: true

##
# Fill in User form
#
def fill_in_user_form_with(fields = {})
  first_name = fields.fetch(:first_name, nil)
  last_name = fields.fetch(:last_name, nil)
  username = fields.fetch(:username, nil)
  email = fields.fetch(:email, nil)
  role = fields.fetch(:role, nil)

  fill_in 'First Name', with: first_name if first_name.present?
  fill_in 'Last Name', with: last_name if last_name.present?
  fill_in 'Username', with: username if username.present?
  fill_in 'Email', with: email if email.present?

  select role, from: 'Role' if role.present?
end

def fill_in_and_create_user_form_with(fields = {})
  fill_in_user_form_with(fields)

  submit_create_user_form
end

def fill_in_and_update_user_form_with(fields = {})
  fill_in_user_form_with(fields)

  submit_update_user_form
end

def submit_create_user_form
  click_button 'Create User'
end

def submit_update_user_form
  click_button 'Update User'
end
