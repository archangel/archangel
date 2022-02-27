# frozen_string_literal: true

node(:success) { response.status == 202 }
node(:status) { response.status }

child(@site, root: :data) do
  extends 'api/v1/sites/item'
end
