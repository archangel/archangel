# frozen_string_literal: true

class SlugValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? || value == value.parameterize

    msg = options[:message] || I18n.t('errors.messages.slug')

    record.errors.add(attribute, msg)
  end
end
