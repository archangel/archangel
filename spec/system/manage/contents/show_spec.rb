# frozen_string_literal: true

RSpec.describe 'Manage Content #show', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:resource) { create(:content, site: site, name: 'My Content') }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)
  end

  describe 'when available' do
    it 'returns 200 status' do
      visit "/manage/contents/#{resource.id}"

      expect(page.status_code).to eq(200)
    end

    it 'returns success when resource is marked as discarded' do
      resource = create(:content, :discarded, site: site)

      visit "/manage/contents/#{resource.id}"

      expect(page.status_code).to eq(200)
    end
  end

  describe 'when not available' do
    it 'returns 404 status' do
      visit '/manage/contents/0'

      expect(page.status_code).to eq(404)
    end

    it 'returns 404 when it does not exist' do
      visit '/manage/contents/0'

      expect(page).to have_content('Error 404')
    end
  end
end
