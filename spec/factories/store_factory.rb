# frozen_string_literal: true

FactoryBot.define do
  factory :store do
    for_content

    sequence(:key) { |n| "meta_#{n}_key" }
    sequence(:value) { |n| "Meta #{n} Value" }

    trait :for_content do
      association :storable, factory: :content
    end

    trait :for_site do
      association :storable, factory: :site
    end
  end
end
