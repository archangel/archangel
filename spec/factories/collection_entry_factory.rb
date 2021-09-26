# frozen_string_literal: true

FactoryBot.define do
  factory :collection_entry, aliases: %i[entry] do
    collection

    # `content` should always be passed
    content { {} }

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
