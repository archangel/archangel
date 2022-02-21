# frozen_string_literal: true

def fill_in_collection_field_form_with(fields = {})
  fill_in_collection_field_resource_form_with(fields)
end

def add_and_fill_in_collection_field_form_with(fields = {})
  click_link 'Add Collection Field'

  fill_in_collection_field_resource_form_with(fields)
end

# rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
def fill_in_collection_field_resource_form_with(fields = {})
  classification = fields.fetch(:classification, nil)
  label = fields.fetch(:label, nil)
  key = fields.fetch(:key, nil)
  required = fields.fetch(:required, false)

  last_item = page.all('#collection_collection_fields .nested-fields').count

  return unless last_item.positive?

  within("#collection_collection_fields .nested-fields:nth-child(#{last_item})") do
    select classification, from: 'Classification' if classification.present?

    fill_in 'Label', with: label if label.present?
    fill_in 'Key', with: key if key.present?

    (required ? check('Required') : uncheck('Required')) if [true, false].include?(required) && !selenium?
    form_checbox_check('Required', required) if [true, false].include?(required) && selenium?
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
