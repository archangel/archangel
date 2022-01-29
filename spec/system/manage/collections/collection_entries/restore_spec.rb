# frozen_string_literal: true

RSpec.describe 'Manage Collection #restore', type: :system, js: true do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  let(:parent_resource_fields) do
    [
      build(:field, :string, label: 'Field Name', key: 'name'),
      build(:field, :string, label: 'Field Slug', key: 'slug')
    ]
  end
  let(:parent_resource) { create(:collection, site: site, collection_fields: parent_resource_fields) }

  let(:resource) do
    create(:collection_entry, :discarded, collection: parent_resource,
                                          content: { name: 'Collection Entry Name', slug: 'entrySlug' })
  end

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)

    visit "/manage/collections/#{parent_resource.id}/collection_entries/#{resource.id}"
  end

  describe 'when successful' do
    it 'recovers the resource and the discard link is now available' do
      within(:css, '.btn-toolbar') do
        expect(page).to have_css('a.btn-restore')
      end
    end

    it 'recovers the resource and the recover link is no longer available' do
      within(:css, '.btn-toolbar') { click_on 'Restore Collection Entry' }

      visit "/manage/collections/#{parent_resource.id}/collection_entries/#{resource.id}"

      within(:css, '.btn-toolbar') do
        expect(page).not_to have_css('a.btn-restore')
      end
    end
  end
end
