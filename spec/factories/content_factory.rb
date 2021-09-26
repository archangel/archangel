# frozen_string_literal: true

FactoryBot.define do
  factory :content do
    site

    sequence(:name) { |n| "Content #{n} Name" }
    sequence(:slug) { |n| "content-#{n}-slug" }
    body { 'This is the body' }
    published_at { Time.current }

    trait :scheduled do
      published_at { 1.day.from_now }
    end

    trait :unpublished do
      published_at { nil }
    end

    trait :discarded do
      discarded_at { Time.current }
    end

    trait :with_stores do
      transient do
        store_count { 2 }
      end

      after(:create) do |page, evaluator|
        create_list(:store, evaluator.store_count, storable: page)
      end
    end
  end
end
