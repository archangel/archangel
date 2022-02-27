# frozen_string_literal: true

##
# Fill in Site form
#
# rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
def fill_in_site_form_with(fields = {})
  name = fields.fetch(:name, nil)
  subdomain = fields.fetch(:subdomain, nil)
  format_date = fields.fetch(:format_date, nil)
  format_datetime = fields.fetch(:format_datetime, nil)
  format_time = fields.fetch(:format_time, nil)
  format_js_date = fields.fetch(:format_js_date, nil)
  format_js_datetime = fields.fetch(:format_js_datetime, nil)
  format_js_time = fields.fetch(:format_js_time, nil)
  regenerate_auth_token_on_login = fields.fetch(:regenerate_auth_token_on_login, false)
  regenerate_auth_token_on_logout = fields.fetch(:regenerate_auth_token_on_logout, false)

  fill_in 'Name', with: name if name.present?
  fill_in 'Subdomain', with: subdomain if subdomain.present?

  if [true, false].include?(regenerate_auth_token_on_login)
    checkbox_label = 'Regenerate auth token on log in'
    (regenerate_auth_token_on_login ? check(checkbox_label) : uncheck(checkbox_label)) unless selenium?
    form_checbox_check(checkbox_label, regenerate_auth_token_on_login) if selenium?
  end

  if [true, false].include?(regenerate_auth_token_on_logout)
    checkbox_label = 'Regenerate auth token on log out'
    (regenerate_auth_token_on_logout ? check(checkbox_label) : uncheck(checkbox_label)) unless selenium?
    form_checbox_check(checkbox_label, regenerate_auth_token_on_logout) if selenium?
  end

  fill_in 'Format Date', with: format_date if format_date.present?
  fill_in 'Format Datetime', with: format_datetime if format_datetime.present?
  fill_in 'Format Time', with: format_time if format_time.present?
  fill_in 'Format JS Date', with: format_js_date if format_js_date.present?
  fill_in 'Format JS Datetime', with: format_js_datetime if format_js_datetime.present?
  fill_in 'Format JS Time', with: format_js_time if format_js_time.present?
end
# rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength

def fill_in_and_update_site_form_with(fields = {})
  fill_in_site_form_with(fields)

  submit_update_site_form
end

def submit_update_site_form
  click_button 'Update Site'
end
