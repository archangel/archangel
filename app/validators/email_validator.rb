# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.match?(/\A[^@]+@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)

    msg = options[:message] || I18n.t('errors.messages.email')

    record.errors.add(attribute, msg)
  end
end
