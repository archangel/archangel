# frozen_string_literal: true

RSpec.describe 'Manage Content #restore', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:resource) { create(:content, :discarded, site: site) }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)

    visit "/manage/contents/#{resource.id}"
  end

  describe 'when successful' do
    it 'recovers the resource and the discard link is now available' do
      within(:css, '.btn-toolbar') do
        expect(page).to have_css('a.btn-restore')
      end
    end

    it 'recovers the resource and the recover link is no longer available' do
      within(:css, '.btn-toolbar') { click_on 'Restore Content' }

      visit "/manage/contents/#{resource.id}"

      within(:css, '.btn-toolbar') do
        expect(page).not_to have_css('a.btn-restore')
      end
    end
  end
end
