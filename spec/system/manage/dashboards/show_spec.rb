# frozen_string_literal: true

RSpec.describe 'Manage Content #show', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)
  end

  describe 'when available' do
    it 'returns 200 status' do
      visit '/manage'

      expect(page.status_code).to eq(200)
    end
  end
end
