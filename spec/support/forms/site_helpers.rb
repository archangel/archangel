# frozen_string_literal: true

##
# Fill in Site form
#
def fill_in_site_form_with(fields = {})
  name = fields.fetch(:name, nil)
  subdomain = fields.fetch(:subdomain, nil)
  format_datetime = fields.fetch(:format_datetime, nil)

  fill_in 'Name', with: name if name.present?
  fill_in 'Subdomain', with: subdomain if subdomain.present?
  fill_in 'Format datetime', with: format_datetime if format_datetime.present?
end

def fill_in_and_update_site_form_with(fields = {})
  fill_in_site_form_with(fields)

  submit_update_site_form
end

def submit_update_site_form
  click_button 'Update Site'
end
