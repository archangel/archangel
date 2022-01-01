# frozen_string_literal: true

module CollectionEntriesHelper
  def collection_entry_status(resource)
    return 'deleted' if resource.discarded?
    return 'draft' if resource.unpublished?
    return 'scheduled' if resource.scheduled?

    'available'
  end

  def collection_entry_value(entry, classification, key)
    value = entry.content[key]

    send("collection_entry_#{classification}", value)
  end

  def collection_entry_string(value)
    value
  end
  alias collection_entry_text collection_entry_string
  alias collection_entry_email collection_entry_string
  alias collection_entry_url collection_entry_string

  ##
  # Boolean Collection Entry formatter
  #
  # Format boolean values as boolean types
  #
  # Example
  #   collection_entry_boolean(true) => true
  #   collection_entry_boolean(1) => true
  #   collection_entry_boolean('true') => true
  #   collection_entry_boolean('t') => true
  #   collection_entry_boolean('yes') => true
  #   collection_entry_boolean('y') => true
  #   collection_entry_boolean('1') => true
  #   collection_entry_boolean(nil) => false
  #   collection_entry_boolean('anything other than the above') => false
  #
  def collection_entry_boolean(value)
    %w[true t yes y 1].include?(value.to_s.downcase)
  end

  def collection_entry_integer(value)
    value.to_i
  end

  def collection_entry_datetime(value)
    _collection_entry_datetime_formatter(value, current_site.format_datetime)
  end

  def collection_entry_date(value)
    _collection_entry_datetime_formatter(value, current_site.format_date)
  end

  def collection_entry_time(value)
    _collection_entry_datetime_formatter(value, current_site.format_time)
  end

  def _collection_entry_datetime_formatter(value, format)
    string_to_datetime = value.present? ? value.to_datetime : nil

    I18n.l(string_to_datetime, format: format, default: nil)
  end
end
