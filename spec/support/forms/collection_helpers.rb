# frozen_string_literal: true

##
# Fill in Collection form
#
def fill_in_collection_form_with(fields = {})
  name = fields.fetch(:name, nil)
  slug = fields.fetch(:slug, nil)
  published_at = fields.fetch(:published_at, nil)

  fill_in 'Name', with: name if name.present?
  fill_in 'Slug', with: slug if slug.present?

  select_flatpickr_date(published_at, from: 'Publish Date') if published_at.present? && selenium?
  fill_in('Publish Date', with: published_at) if published_at.present? && !selenium?
end

def fill_in_and_create_collection_form_with(fields = {})
  fill_in_collection_form_with(fields)

  submit_create_collection_form
end

def fill_in_and_update_collection_form_with(fields = {})
  fill_in_collection_form_with(fields)

  submit_update_collection_form
end

def submit_create_collection_form
  click_button 'Create Collection'
end

def submit_update_collection_form
  click_button 'Update Collection'
end
