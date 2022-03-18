# frozen_string_literal: true

node :collection_entry do
  policy = CollectionEntryPolicy.new(@profile, :resource)

  {
    index: policy.index?,
    show: policy.show?,
    new: policy.new?,
    create: policy.create?,
    edit: policy.edit?,
    update: policy.update?,
    destroy: policy.destroy?,
    restore: policy.restore?,
    reposition: policy.reposition?
  }
end
