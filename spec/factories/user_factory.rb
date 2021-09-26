# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) { |n| "email#{n}@example.com" }
    password { 'password1234' }
    confirmed_at { Time.current }
    invitation_accepted_at { Time.current }

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

    trait :invited do
      sequence(:invitation_token) { |n| "invitation-token-#{n}" }
      invitation_sent_at { Time.current }
      invitation_accepted_at { nil }
    end

    trait :accepted do
      invitation_token { nil }
      invitation_created_at { Time.current }
      invitation_accepted_at { Time.current }
      invitation_sent_at { Time.current }
    end

    trait :tracked do
      sign_in_count { 2 }
      current_sign_in_at { Time.current }
      last_sign_in_at { 1.day.ago }
      current_sign_in_ip { '127.0.0.1' }
      last_sign_in_ip { '127.0.0.1' }
    end

    trait :reset do
      sequence(:reset_password_token) { |n| "reset-token-#{n}" }
      reset_password_sent_at { Time.current }
    end
  end
end
