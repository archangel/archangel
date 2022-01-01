# frozen_string_literal: true

##
# Fill in Collection Entry form
#
def fill_in_collection_entry_form_with(fields = {})
  published_at = fields.fetch(:published_at, nil)

  select_flatpickr_date(published_at, from: 'Publish Date') if published_at.present? && js_driver
  fill_in('Publish Date', with: published_at) if published_at.present? && !js_driver
end

def fill_in_and_create_collection_entry_form_with(fields = {})
  fill_in_collection_form_with(fields)

  submit_create_collection_form
end

def fill_in_and_update_collection_entry_form_with(fields = {})
  fill_in_collection_form_with(fields)

  submit_update_collection_entry_form
end

def submit_create_collection_entry_form
  click_button 'Create Collection Entry'
end

def submit_update_collection_entry_form
  click_button 'Update Collection Entry'
end
