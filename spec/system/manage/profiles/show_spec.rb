# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manage Profile #show', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)
  end

  describe 'when available' do
    it 'returns 200 status' do
      visit '/manage/profile'

      expect(page.status_code).to eq(200)
    end
  end
end
