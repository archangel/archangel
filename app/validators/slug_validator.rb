# frozen_string_literal: true

# Custom validator for slug
class SlugValidator < ActiveModel::EachValidator
  # Slug validator
  #
  # Validate parameterized string
  #
  # @example With general validation
  #   validates :name, slug: true
  #
  # @example With custom validation message
  #   validates :name, slug: { message: 'is not a valid slug' }
  #
  # @param [Object] record data resource
  # @param [String] attribute data column name
  # @param [String] value value to be validated
  # @return [nil,String] nil if no validation issues, error message if validation error found
  def validate_each(record, attribute, value)
    return if value.blank? || value == value.parameterize

    msg = options[:message] || I18n.t('errors.messages.slug')

    record.errors.add(attribute, msg)
  end
end
