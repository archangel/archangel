# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manage Collection Entries #index', type: :system do
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

  describe 'with results' do
    before do
      ('A'..'Z').reverse_each do |letter|
        create(:collection_entry, collection: parent_resource,
                                  content: { name: "Collection Entry #{letter} Name", slug: "entrySlug#{letter}" })
      end
    end

    describe 'with default sort order (`position` 0-999)' do
      before { visit "/manage/collections/#{parent_resource.id}/collection_entries" }

      it 'lists the first resource' do
        within('table.table tbody tr:nth-child(1)') do
          expect(page).to have_content('Collection Entry A Name')
        end
      end

      it 'does not list the first resource outside of pagination scope' do
        expect(page).not_to have_content('Collection Entry Y Name')
      end
    end

    describe 'with paginated records' do
      it 'finds the second page of Collections' do
        visit "/manage/collections/#{parent_resource.id}/collection_entries?page=2"

        expect(page).to have_content('Collection Entry Y Name')
      end

      it 'does not find the first page of Collections with `per` count' do
        visit "/manage/collections/#{parent_resource.id}/collection_entries?page=2&per=3"

        expect(page).not_to have_content('Collection Entry A Name')
      end

      it 'finds the second page of Collections with `per` count' do
        visit "/manage/collections/#{parent_resource.id}/collection_entries?page=2&per=3"

        expect(page).to have_content('Collection Entry D Name')
      end

      it 'finds nothing outside the count' do
        visit "/manage/collections/#{parent_resource.id}/collection_entries?page=2&per=26"

        expect(page).to have_content('No collection entries available')
      end
    end

    describe 'includes' do
      before do
        create(:collection_entry,
               :discarded,
               collection: parent_resource,
               content: { name: 'Collection Entry Discarded Name', slug: 'discardedEntrySlug' })
      end

      it 'includes discarded Collection Entries' do
        visit "/manage/collections/#{parent_resource.id}/collection_entries"

        within('table.table tbody tr:nth-child(1)') do
          expect(page).to have_content('Collection Entry Discarded Name')
        end
      end

      it 'marks discarded Collection Entries' do
        visit "/manage/collections/#{parent_resource.id}/collection_entries"

        expect(page).to have_css('table.table tbody tr:nth-child(1).status-deleted')
      end
    end
  end

  describe 'without results' do
    it 'shows a message saying no records available' do
      visit "/manage/collections/#{parent_resource.id}/collection_entries"

      expect(page).to have_content('No collection entries available')
    end
  end
end
