# frozen_string_literal: true

node :site do
  policy = SitePolicy.new(@profile, :resource)

  {
    show: policy.show?,
    edit: policy.edit?,
    update: policy.update?
  }
end
