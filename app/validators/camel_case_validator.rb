# frozen_string_literal: true

# Custom validator for camelCase
class CamelCaseValidator < ActiveModel::EachValidator
  # Camel case validator
  #
  # Must start with a lower case letter. `camelCase` is valid. `CamelCase` is not valid. `1camel` is not valid
  #
  # @example With general validation
  #   validates :name, camel_case: true
  #
  # @example With custom validation message
  #   validates :name, camel_case: { message: 'is not camel case' }
  #
  # @param [Object] record data resource
  # @param [String] attribute data column name
  # @param [String] value value to be validated
  # @return [nil,String] nil if no validation issues, error message if validation error found
  def validate_each(record, attribute, value)
    return if value.blank? || value.match?(/^[a-z]+[a-zA-Z0-9]*$/)

    msg = options[:message] || I18n.t('errors.messages.camel_case')

    record.errors.add(attribute, msg)
  end
end
