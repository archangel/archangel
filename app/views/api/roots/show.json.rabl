# frozen_string_literal: true

node(:success) { response.status == 200 }
node(:status) { response.status }

child :data do
  node :versions do
    {
      1 => api_v1_url
    }
  end
end
