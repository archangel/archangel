# frozen_string_literal: true

object @profile
attributes :email, :username, :first_name, :last_name, :name
node(:locked) { |profile| profile.locked_at.present? }
