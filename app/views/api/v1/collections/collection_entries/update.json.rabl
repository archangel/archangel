# frozen_string_literal: true

node(:success) { response.status == 202 }
node(:status) { response.status }

child(@collection_entry, root: :data) do
  extends 'api/v1/collections/collection_entries/item'
end
