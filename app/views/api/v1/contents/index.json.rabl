# frozen_string_literal: true

node(:success) { response.status == 200 }
node(:status) { response.status }

child(@contents => :data) do
  extends 'api/v1/contents/item'
end
