# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationJob, type: :job do
  it 'returns truthy' do
    expect(true).to be_truthy
  end
end
