# frozen_string_literal: true

# Custom validator for email address
class EmailValidator < ActiveModel::EachValidator
  # Email validator
  #
  # Validate email address format. Does not validate that email is legitimate
  #
  # @example With general validation
  #   validates :contact, email: true
  #
  # @example With custom validation message
  #   validates :contact, email: { message: 'is not a valid email address' }
  #
  # @param [Object] record data resource
  # @param [String] attribute data column name
  # @param [String] value value to be validated
  # @return [nil,String] nil if no validation issues, error message if validation error found
  def validate_each(record, attribute, value)
    return if value.blank? || value.match?(/\A[^@]+@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)

    msg = options[:message] || I18n.t('errors.messages.email')

    record.errors.add(attribute, msg)
  end
end
