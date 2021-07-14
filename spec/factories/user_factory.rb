# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) { |n| "email#{n}@example.com" }
    password { 'password1234' }
    confirmed_at { Time.current }

    trait :password_reset do
      sequence(:reset_password_token) { |n| "reset-password-token-#{n}" }
      reset_password_sent_at { Time.current }
    end

    trait :unconfirmed do
      confirmation_token { 'abcdefghijklmnopqrstuvwxyz' }
      confirmed_at { nil }
      confirmation_sent_at { Time.current }
      sequence(:unconfirmed_email) { |n| "email#{n}@example.com" }
    end

    trait :locked do
      failed_attempts { 5 }
      sequence(:unlock_token) { |n| "unlock-token-#{n}" }
      locked_at { Time.current }
    end
  end
end
