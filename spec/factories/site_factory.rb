# frozen_string_literal: true

FactoryBot.define do
  factory :site do
    sequence(:name) { |n| "Site #{n} Name" }
    sequence(:subdomain) { |n| "subdomain#{n}" }

    trait :discarded do
      discarded_at { Time.current }
    end

    trait :with_stores do
      transient do
        store_count { 2 }
      end

      after(:create) do |site, evaluator|
        create_list(:store, evaluator.store_count, storable: site)
      end
    end
  end
end
