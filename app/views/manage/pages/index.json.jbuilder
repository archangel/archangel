# frozen_string_literal: true

json.array! @pages, partial: 'manage/pages/page', as: :page
