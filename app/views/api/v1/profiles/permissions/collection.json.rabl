# frozen_string_literal: true

node :collection do
  policy = CollectionPolicy.new(@profile, :resource)

  {
    index: policy.index?,
    show: policy.show?,
    new: policy.new?,
    create: policy.create?,
    edit: policy.edit?,
    update: policy.update?,
    destroy: policy.destroy?,
    restore: policy.restore?
  }
end
