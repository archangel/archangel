# frozen_string_literal: true

def add_and_fill_in_site_store_form_with(fields = {})
  click_link 'Add Store'

  fill_in_site_store_form_with(fields)
end

def fill_in_site_store_form_with(fields = {})
  key = fields.fetch(:key, nil)
  value = fields.fetch(:value, nil)

  last_item = page.all('#site_stores .nested-fields').count

  return unless last_item.positive?

  within(:css, "#site_stores .nested-fields:nth-child(#{last_item})") do
    fill_in 'Key', with: key if key.present?
    fill_in 'Value', with: value if value.present?
  end
end
