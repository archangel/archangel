# frozen_string_literal: true

RSpec.describe 'Manage Collection Entry #show', type: :system do
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

  describe 'when available' do
    let(:discard_resource) do
      create(:collection_entry,
             :discarded,
             collection: parent_resource,
             content: { name: 'Deleted Collection Entry Name', slug: 'deletedEntry' })
    end

    it 'returns 200 status' do
      visit "/manage/collections/#{parent_resource.id}/collection_entries/#{resource.id}"

      expect(page.status_code).to eq(200)
    end

    it 'returns success even when resource is marked as discarded' do
      visit "/manage/collections/#{parent_resource.id}/collection_entries/#{discard_resource.id}"

      expect(page.status_code).to eq(200)
    end
  end

  describe 'when not available' do
    xit 'returns 404 status' do
      visit '/manage/collections/0'

      expect(page.status_code).to eq(404)
    end

    xit 'returns 404 when it does not exist' do
      visit '/manage/collections/0'

      expect(page).to have_content('Error 404')
    end
  end
end
