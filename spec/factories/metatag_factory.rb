# frozen_string_literal: true

FactoryBot.define do
  factory :metatag do
    for_page

    sequence(:name) { |n| "metatag_#{n}_name" }
    sequence(:content) { |n| "Meta Tag #{n} Content" }

    trait :for_page do
      association :metatagable, factory: :page
    end

    trait :for_site do
      association :metatagable, factory: :site
    end
  end
end
