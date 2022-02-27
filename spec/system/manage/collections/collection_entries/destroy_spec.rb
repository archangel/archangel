# frozen_string_literal: true

RSpec.describe 'Manage Collection Entry #destroy', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  let(:parent_resource_fields) do
    [
      build(:field, :string, label: 'Field Name', key: 'name'),
      build(:field, :string, label: 'Field Slug', key: 'slug')
    ]
  end
  let(:parent_resource) { create(:collection, site: site, collection_fields: parent_resource_fields) }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)
  end

  describe 'when deleting' do
    before do
      create(:collection_entry, collection: parent_resource, content: { name: 'Delete Me', slug: 'entrySlugA' })
      create(:collection_entry, collection: parent_resource, content: { name: 'Keep Me', slug: 'entrySlugB' })

      visit "/manage/collections/#{parent_resource.id}/collection_entries"

      within(:css, 'table.table tbody tr:nth-child(2)') do
        click_on 'Delete Collection Entry'
      end
    end

    it 'returns a success message' do
      expect(page).to have_content('Collection Entry was successfully destroyed.')
    end

    it 'still lists discarded resource' do
      within(:css, 'table.table tbody tr:nth-child(2)') do
        expect(page).to have_content('Delete Me')
      end
    end

    it 'has deleted style on discarded resource' do
      within(:css, 'table.table tbody') do
        expect(page).to have_css('tr:nth-child(2).status-deleted')
      end
    end
  end

  describe 'when destroying' do
    before do
      create(:collection_entry, :discarded, collection: parent_resource,
                                            content: { name: 'Destroy Me', slug: 'entrySlugA' })
      create(:collection_entry, collection: parent_resource, content: { name: 'Keep Me', slug: 'entrySlugB' })

      visit "/manage/collections/#{parent_resource.id}/collection_entries"

      within(:css, 'table.table tbody tr:nth-child(2)') do
        click_on 'Destroy Collection Entry'
      end
    end

    it 'returns a success message' do
      expect(page).to have_content('Collection Entry was successfully destroyed.')
    end

    it 'does not list destrayed resource' do
      within(:css, 'table.table tbody') do
        expect(page).not_to have_content('Destroy Me')
      end
    end
  end
end
