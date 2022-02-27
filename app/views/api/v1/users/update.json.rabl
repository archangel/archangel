# frozen_string_literal: true

node(:success) { response.status == 202 }
node(:status) { response.status }

child(@user, root: :data) do
  extends 'api/v1/users/item'
end
