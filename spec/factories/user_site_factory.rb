# frozen_string_literal: true

FactoryBot.define do
  factory :user_site do
    user { association :user }
    site { association :site }

    admin_role

    %w[admin editor reader].each do |role_name|
      trait :"#{role_name}_role" do
        role { role_name }
      end
    end
  end
end
