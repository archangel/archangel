# frozen_string_literal: true

json.array! @users, partial: 'manage/users/user', as: :user
