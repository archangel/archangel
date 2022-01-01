# frozen_string_literal: true

json.array! @collections, partial: 'manage/collections/collection', as: :collection
