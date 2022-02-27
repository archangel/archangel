# frozen_string_literal: true

node(:success) { response.status == 202 }
node(:status) { response.status }

child(@user => :data) do
  extends 'api/v1/sessions/item'
end
