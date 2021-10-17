# frozen_string_literal: true

class CamelCaseValidator < ActiveModel::EachValidator
  ##
  # Camel case validator
  #
  # Must start with a lower case letter. `camelCase` is valid. `CamelCase` is not valid. `1camel` is not valid
  #
  # Example
  #   validates :name, camel_case: true
  #   validates :name, camel_case: { message: 'is not camel case' }
  #
  def validate_each(record, attribute, value)
    return if value.match?(/^[a-z]+[a-zA-Z0-9]*$/)

    msg = options[:message] || I18n.t('errors.messages.camel_case')

    record.errors.add(attribute, msg)
  end
end
