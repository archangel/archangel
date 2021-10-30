# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home #show', type: :system do
  describe 'when available' do
    it 'returns 200 status' do
      visit '/'

      expect(page.status_code).to eq(200)
    end
  end
end
