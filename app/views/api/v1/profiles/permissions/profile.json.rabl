# frozen_string_literal: true

node :profile do
  policy = ProfilePolicy.new(@profile, :resource)

  {
    show: policy.show?,
    edit: policy.edit?,
    update: policy.update?
  }
end
