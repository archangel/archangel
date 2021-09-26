# frozen_string_literal: true

FactoryBot.define do
  factory :collection_field, aliases: %i[field] do
    collection

    sequence(:label) { |n| "Field #{n} Label" }
    sequence(:key) { |n| "field-#{n}-key" }
    required { true }

    string

    %w[string integer boolean datetime date time].each do |classification_name|
      trait :"#{classification_name}" do
        classification { classification_name }
      end
    end
  end
end
