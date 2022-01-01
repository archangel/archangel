# frozen_string_literal: true

module EntryValidatableConcern
  extend ActiveSupport::Concern

  included do
    store :content, coder: JSON

    validates :content, presence: true, allow_blank: true

    after_initialize :add_accessor_and_validator_for_entry_fields,
                     :add_classification_validator_for_entry_fields

    def self.add_boolean_validator(field, _allow_blank)
      validates field, inclusion: { in: %w[0 1] }
    end

    def self.add_date_validator(field, allow_blank)
      validates field, timeliness: { allow_blank: allow_blank, type: :date }
    end

    def self.add_datetime_validator(field, allow_blank)
      validates field, timeliness: { allow_blank: allow_blank, type: :datetime }
    end

    def self.add_email_validator(field, allow_blank)
      validates field, allow_blank: allow_blank, email: true
    end

    def self.add_integer_validator(field, allow_blank)
      validates field, allow_blank: allow_blank, numericality: { only_integer: true }
    end

    def self.add_time_validator(field, allow_blank)
      validates field, timeliness: { allow_blank: allow_blank, type: :time }
    end

    def self.add_url_validator(field, allow_blank)
      validates field, allow_blank: allow_blank, url: true
    end
  end

  def add_accessor_and_validator_for_entry_fields
    (resource_value_fields || []).each do |field|
      singleton_class.class_eval do
        store_accessor :content, field.key.to_sym

        validates field.key.to_sym, presence: true if field.required?
      end
    end
  end

  def add_classification_validator_for_entry_fields
    classifications = %w[boolean date datetime email integer time url]

    (resource_value_fields || []).each do |field|
      singleton_class.class_eval do
        if classifications.include?(field.classification)
          send("add_#{field.classification}_validator".to_sym, field.key.to_sym, !field.required?)
        end
      end
    end
  end
end