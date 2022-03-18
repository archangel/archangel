# frozen_string_literal: true

node :user do
  policy = UserPolicy.new(@profile, :resource)

  {
    index: policy.index?,
    show: policy.show?,
    new: policy.new?,
    create: policy.create?,
    edit: policy.edit?,
    update: policy.update?,
    destroy: policy.destroy?,
    reinvite: policy.reinvite?,
    retoken: policy.retoken?,
    unlock: policy.unlock?
  }
end
