# frozen_string_literal: true

# Custom validator for URL
class UrlValidator < ActiveModel::EachValidator
  # URL validator
  #
  # Validate URL format. Does not validate that URL is accessible
  #
  # @example With general validation
  #   validates :website, url: true
  #
  # @example With custom validation message
  #   validates :website, url: { message: 'is not a valid web address' }
  #
  # @param [Object] record data resource
  # @param [String] attribute data column name
  # @param [String] value value to be validated
  # @return [nil,String] nil if no validation issues, error message if validation error found
  def validate_each(record, attribute, value)
    return if value.blank? || url_valid?(value)

    msg = options[:message] || I18n.t('errors.messages.url')

    record.errors.add(attribute, msg)
  end

  private

  def url_valid?(url)
    url = URI.parse(url)
    url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)
  rescue StandardError
    false
  end
end
