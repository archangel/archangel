# frozen_string_literal: true

node(:success) { response.status == 200 }
node(:status) { response.status }

child(@collection, root: :data) do
  extends 'api/v1/collections/item'
end
