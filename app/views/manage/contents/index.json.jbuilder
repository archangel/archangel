# frozen_string_literal: true

json.array! @contents, partial: 'manage/contents/content', as: :content
