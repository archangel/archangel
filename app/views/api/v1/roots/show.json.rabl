# frozen_string_literal: true

node(:success) { response.status == 200 }
node(:status) { response.status }

node :data do
  {
    version: 1
  }
end
