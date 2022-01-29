# frozen_string_literal: true

RSpec.describe 'Manage Content #edit', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:resource) { create(:content, site: site, name: 'My Content') }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)

    visit "/manage/contents/#{resource.id}/edit"
  end

  describe 'when successful' do
    it 'returns success message' do
      fill_in_and_update_content_form_with(name: 'Wonderful Content')

      expect(page).to have_content('Content was successfully updated.')
    end
  end

  describe 'when not successful' do
    it 'fails without `name`' do
      fill_in 'Name', with: ''

      submit_update_content_form

      expect(page.find('.string.content_name')).to have_content("can't be blank")
    end

    it 'fails with existing `slug`' do
      create(:content, site: site, slug: 'wonderful')

      fill_in 'Slug', with: 'wonderful'

      submit_update_content_form

      expect(page.find('.slug.content_slug')).to have_content('has already been taken')
    end
  end
end
