# frozen_string_literal: true

node(:success) { response.status == 201 }
node(:status) { response.status }

child(@content, root: :data) do
  extends 'api/v1/contents/item'
end
