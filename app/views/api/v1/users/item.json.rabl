# frozen_string_literal: true

object @user
attributes :email, :username, :first_name, :last_name, :name
node(:locked) { |user| user.locked_at.present? }
