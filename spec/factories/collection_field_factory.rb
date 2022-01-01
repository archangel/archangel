# frozen_string_literal: true

FactoryBot.define do
  factory :collection_field, aliases: %i[field] do
    collection

    classification { 'string' }
    sequence(:label) { |n| "Field #{n} Label" }
    sequence(:key) { |n| "fieldKey#{n}" }
    required { false }

    %w[string integer boolean datetime date time].each do |classification_name|
      trait :"#{classification_name}" do
        classification { classification_name }
      end
    end

    trait :required do
      required { true }
    end
  end
end
