# frozen_string_literal: true

RSpec.describe 'Manage Collection Entry #history', type: :system do
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
    create(:collection_entry, collection: parent_resource,
                              content: { name: 'Collection Entry Name', slug: 'entrySlug' })
  end

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)
  end

  describe 'when available', versioning: true do
    it 'lists only one version (create)' do
      visit "/manage/collections/#{parent_resource.id}/collection_entries/#{resource.id}/history"

      expect(page).to have_selector('#version_history table tbody tr', count: 1)
    end

    describe 'with multiple versions' do
      before do
        resource.update(content: { name: 'Updated Name', slug: 'updatedSlug' })
        resource.update(content: { name: 'New Updated Name', slug: 'newUpdatedSlug' })
      end

      it 'lists multiple versions' do
        visit "/manage/collections/#{parent_resource.id}/collection_entries/#{resource.id}/history"

        expect(page).to have_selector('#version_history > table > tbody > tr', count: 3)
      end
    end
  end

  describe 'when no versions available' do
    it 'shows a message saying no records available' do
      visit "/manage/collections/#{parent_resource.id}/collection_entries/#{resource.id}/history"

      expect(page).to have_content('No collection entry versions available')
    end
  end
end
