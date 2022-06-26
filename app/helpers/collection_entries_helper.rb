# frozen_string_literal: true

# Collection Entry helpers
module CollectionEntriesHelper
  # Collection Entry status
  #
  # @example With Collection Entry resource that is discarded
  #   <%= collection_entry_status(resource) %> #=> 'deleted'
  #
  # @example With Collection Entry resource that has not been published
  #   <%= collection_entry_status(resource) %> #=> 'draft'
  #
  # @example With Collection Entry resource that is published but not available
  #   <%= collection_entry_status(resource) %> #=> 'scheduled'
  #
  # @example With Collection Entry resource that is currently available
  #   <%= collection_entry_status(resource) %> #=> 'available'
  #
  # @param [Object] resource Collection Entry object
  # @return [String] status name
  def collection_entry_status(resource)
    return 'deleted' if resource.discarded?
    return 'draft' if resource.unpublished?
    return 'scheduled' if resource.scheduled?

    'available'
  end

  # Formatted CollectionEntry value
  #
  # @see CollectionEntriesHelper#collection_entry_string
  # @see CollectionEntriesHelper#collection_entry_text
  # @see CollectionEntriesHelper#collection_entry_email
  # @see CollectionEntriesHelper#collection_entry_url
  # @see CollectionEntriesHelper#collection_entry_boolean
  # @see CollectionEntriesHelper#collection_entry_integer
  # @see CollectionEntriesHelper#collection_entry_datetime
  # @see CollectionEntriesHelper#collection_entry_date
  # @see CollectionEntriesHelper#collection_entry_time
  #
  # @param [Object] entry Collection Entry object
  # @param [String] classification classification type
  # @param [String] key content key
  # @return [String,Boolean,Integer] formatted value based on classification
  def collection_entry_value(entry, classification, key)
    value = entry.content[key]

    send("collection_entry_#{classification}", value)
  end

  # CollectionEntry string formatter
  #
  # Passthrough. No formatting applied
  #
  # @param [String] value content key value
  # @return [String] unformatted string
  def collection_entry_string(value)
    value.to_s
  end

  # Collection Entry text formatter
  #
  # Passthrough. No formatting applied
  #
  # @see CollectionEntriesHelper#collection_entry_string
  #
  # @return [String] unformatted string
  alias collection_entry_text collection_entry_string

  # Collection Entry email formatter
  #
  # Passthrough. No formatting applied
  #
  # @see CollectionEntriesHelper#collection_entry_string
  #
  # @return [String] unformatted string
  alias collection_entry_email collection_entry_string

  # Collection Entry URL formatter
  #
  # Passthrough. No formatting applied
  #
  # @see CollectionEntriesHelper#collection_entry_string
  #
  # @return [String] unformatted string
  alias collection_entry_url collection_entry_string

  # Collection Entry URL formatter
  #
  # Format boolean values as boolean types
  #
  # @example Boolean type
  #   collection_entry_boolean(true) => true
  #
  # @example Number type
  #   collection_entry_boolean(1) => true
  #
  # @example Number string type
  #   collection_entry_boolean('1') => true
  #
  # @example Boolean type
  #   collection_entry_boolean(true) => true
  #
  # @example Boolean string type
  #   collection_entry_boolean('true') => true
  #
  # @example Single true type
  #   collection_entry_boolean('t') => true
  #
  # @example Yes type
  #   collection_entry_boolean('yes') => true
  #
  # @example Single yes type
  #   collection_entry_boolean('y') => true
  #
  # @example Null type
  #   collection_entry_boolean(nil) => false
  #
  # @example Unexpected type
  #   collection_entry_boolean('anything unexpected') => false
  #
  # @param [String] value content key value
  # @return [String] unformatted string
  def collection_entry_boolean(value)
    %w[true t yes y 1].include?(value.to_s.downcase)
  end

  # Collection Entry integer formatter
  #
  # Format integer values as integer types
  #
  # @example String number type
  #   collection_entry_integer('1') => 1
  #
  # @example String number type
  #   collection_entry_integer('3.14') => 3
  #
  # @example Number type
  #   collection_entry_integer(1) => 1
  #
  # @example Unidentified integer type
  #   collection_entry_integer('hello') => 0
  #
  # @param [Integer,String] value content key value
  # @return [Integer] integer
  def collection_entry_integer(value)
    value.to_i
  end

  # Collection Entry datetime formatter
  #
  # Format datetime values as datetime types. Returns datetime formatted as preferred datetime format as `Site.format_datetime`
  #
  # @example Datetime type
  #   collection_entry_datetime('2022-03-12 03:41:18') => 'March 12, 2022 @ 03:41 am'
  #
  # @example Datetime type
  #   collection_entry_datetime('2022-03-12') => 'March 12, 2022 @ 12:00 am'
  #
  # @example Datetime type
  #   collection_entry_datetime('') => nil
  #
  # @example Datetime type
  #   collection_entry_datetime(nil) => nil
  #
  # @example Datetime type
  #   collection_entry_datetime('not a date') => nil
  #
  # @param [String] value content key value
  # @return [String] formatted datetime
  def collection_entry_datetime(value)
    _collection_entry_datetime_formatter(value, current_site.format_datetime)
  end

  # Collection Entry date formatter
  #
  # Format date values as date types. Returns date formatted as preferred date format as `Site.format_date`
  #
  # @example Date type
  #   collection_entry_date('2022-03-12 03:41:18') => 'March 12, 2022'
  #
  # @example Date type
  #   collection_entry_date('2022-03-12') => 'March 12, 2022'
  #
  # @example Date type
  #   collection_entry_date('') => nil
  #
  # @example Date type
  #   collection_entry_date(nil) => nil
  #
  # @example Date type
  #   collection_entry_date('not a date') => nil
  #
  # @param [String] value content key value
  # @return [String] formatted date
  def collection_entry_date(value)
    _collection_entry_datetime_formatter(value, current_site.format_date)
  end

  # Collection Entry time formatter
  #
  # Format time values as time types. Returns time formatted as preferred time format as `Site.format_time`
  #
  # @example Time type
  #   collection_entry_time('2022-03-12 03:41:18') => '03:41 am'
  #
  # @example Time type
  #   collection_entry_time('2022-03-12') => '12:00 am'
  #
  # @example Time type
  #   collection_entry_time('03:41:18') => '03:41 am'
  #
  # @example Time type
  #   collection_entry_time('') => nil
  #
  # @example Time type
  #   collection_entry_time(nil) => nil
  #
  # @example Time type
  #   collection_entry_time('not a date') => nil
  #
  # @param [String] value content key value
  # @return [String] formatted time
  def collection_entry_time(value)
    _collection_entry_datetime_formatter(value, current_site.format_time)
  end

  private

  def _collection_entry_datetime_formatter(value, format)
    return nil if value.blank?

    string_to_datetime = _collection_entry_datetime_to_datetime(value)

    I18n.l(string_to_datetime, format: format, default: nil)
  end

  def _collection_entry_datetime_to_datetime(value)
    return value if value.is_a?(DateTime)

    value.to_datetime
  rescue StandardError
    nil
  end
end
