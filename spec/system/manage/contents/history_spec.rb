# frozen_string_literal: true

RSpec.describe 'Manage Content #history', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:resource) { create(:content, site: site, name: 'My Content') }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)
  end

  describe 'when available', versioning: true do
    it 'lists only one version (create)' do
      visit "/manage/contents/#{resource.id}/history"

      expect(page).to have_selector('#version_history table tbody tr', count: 1)
    end

    describe 'with multiple versions' do
      before do
        resource.update(name: 'Updated Name')
        resource.update(name: 'Second Updated Name')
      end

      it 'lists multiple versions' do
        visit "/manage/contents/#{resource.id}/history"

        expect(page).to have_selector('#version_history > table > tbody > tr', count: 3)
      end
    end
  end

  describe 'when no versions available' do
    it 'shows a message saying no records available' do
      visit "/manage/contents/#{resource.id}/history"

      expect(page).to have_content('No content versions available')
    end
  end
end
