# frozen_string_literal: true

class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? || url_valid?(value)

    msg = options[:message] || I18n.t('errors.messages.url')

    record.errors.add(attribute, msg)
  end

  def url_valid?(url)
    url = URI.parse(url)
    url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)
  rescue StandardError
    false
  end
end
