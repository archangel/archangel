# frozen_string_literal: true

FactoryBot.define do
  factory :page do
    sequence(:title) { |n| "Page #{n} Title" }
    sequence(:slug) { |n| "page-#{n}-slug" }
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
  end
end
