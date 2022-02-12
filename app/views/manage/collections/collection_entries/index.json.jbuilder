# frozen_string_literal: true

json.array! @collection_entries, partial: 'manage/collections/collection_entries/collection_entry',
                                 as: :collection_entry
