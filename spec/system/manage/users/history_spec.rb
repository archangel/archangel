# frozen_string_literal: true

RSpec.describe 'Manage User #history', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:resource) { create(:user) }

  before do
    create(:user_site, user: profile, site: site)
    create(:user_site, user: resource, site: site)

    sign_in(profile)
  end

  describe 'when available', versioning: true do
    it 'lists only one version (create)' do
      visit "/manage/users/#{resource.id}/history"

      expect(page).to have_selector('#version_history table tbody tr', count: 1)
    end

    describe 'with multiple versions' do
      before do
        resource.update(first_name: 'David', last_name: 'F')
        resource.update(first_name: 'Alison', last_name: 'S')
      end

      it 'lists multiple versions' do
        visit "/manage/users/#{resource.id}/history"

        expect(page).to have_selector('#version_history > table > tbody > tr', count: 3)
      end
    end
  end

  describe 'when no versions available' do
    it 'shows a message saying no records available' do
      visit "/manage/users/#{resource.id}/history"

      expect(page).to have_content('No user versions available')
    end
  end
end
