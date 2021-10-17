# frozen_string_literal: true

##
# Fill in Content form
#
def fill_in_content_form_with(fields = {})
  name = fields.fetch(:name, nil)
  slug = fields.fetch(:slug, nil)
  body = fields.fetch(:body, nil)
  published_at = fields.fetch(:published_at, nil)

  fill_in 'Name', with: name if name.present?
  fill_in 'Slug', with: slug if slug.present?

  fill_in_jodit('Body', with: body) if body.present? && js_driver
  fill_in('Body', with: body) if body.present? && !js_driver

  select_flatpickr_date(published_at, from: 'Publish Date') if published_at.present? && js_driver
  fill_in('Publish Date', with: published_at) if published_at.present? && !js_driver
end

def fill_in_and_create_content_form_with(fields = {})
  fill_in_content_form_with(fields)

  submit_create_content_form
end

def fill_in_and_update_content_form_with(fields = {})
  fill_in_content_form_with(fields)

  submit_update_content_form
end

def submit_create_content_form
  click_button 'Create Content'
end

def submit_update_content_form
  click_button 'Update Content'
end
