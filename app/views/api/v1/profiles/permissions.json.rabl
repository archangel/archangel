# frozen_string_literal: true

node(:success) { response.status == 200 }
node(:status) { response.status }

child(@profile => :data) do
  extends 'api/v1/profiles/permissions/collection'
  extends 'api/v1/profiles/permissions/collection_entry'
  extends 'api/v1/profiles/permissions/content'
  extends 'api/v1/profiles/permissions/profile'
  extends 'api/v1/profiles/permissions/site'
  extends 'api/v1/profiles/permissions/user'
end
