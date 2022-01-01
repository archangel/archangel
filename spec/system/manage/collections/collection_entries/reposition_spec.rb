# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manage Collection Entry #reposition', type: :system, js: true do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  let(:parent_resource_fields) do
    [
      build(:field, :string, label: 'Name', key: 'name')
    ]
  end
  let(:parent_resource) { create(:collection, site: site, collection_fields: parent_resource_fields) }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)
  end

  describe 'reposition' do
    before do
      ('A'..'C').reverse_each do |letter|
        create(:collection_entry, collection: parent_resource, content: { name: "Entry #{letter} Name" })
      end

      visit "/manage/collections/#{parent_resource.id}/collection_entries"
    end

    it 'can drag/drop entry to reposition' do
      drag_item('tbody.sortable-collection-entries', '.item-collection-entry', 3, 1)

      visit "/manage/collections/#{parent_resource.id}/collection_entries"

      within(:css, 'table.table tbody tr:nth-child(1)') do
        expect(page).to have_content('Entry C Name')
      end
    end

    xit 'shows flash message after reposition' do
      drag_item('tbody.sortable-collection-entries', '.item-collection-entry', 3, 1)

      wait_for { page.has_css?('.toast.toast-success') }

      expect(page).to have_content('Reposition successful')
    end
  end
end
