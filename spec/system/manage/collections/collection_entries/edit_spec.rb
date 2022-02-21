# frozen_string_literal: true

RSpec.describe 'Manage Collection Entry #edit', type: :system, js: true do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  let(:parent_resource_fields) do
    [
      build(:field, :string, label: 'Field Name', key: 'name', required: true),
      build(:field, :string, label: 'Field Slug', key: 'slug', required: true)
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

    visit "/manage/collections/#{parent_resource.id}/collection_entries/#{resource.id}/edit"
  end

  describe 'when successful' do
    it 'returns success message' do
      fill_in 'Field Name (name)', with: 'James Bond'

      submit_update_collection_entry_form

      expect(page).to have_content('Collection Entry was successfully updated.')
    end

    it 'is valid without a Publish Date' do
      select_flatpickr_date('', from: 'Publish Date')

      submit_update_collection_entry_form

      expect(page).to have_content('Collection Entry was successfully updated.')
    end
  end

  describe 'when not successful' do
    it 'fails without required field' do
      fill_in 'Field Name (name)', with: ''

      submit_update_collection_entry_form

      expect(page.find('.string.collection_entry_name')).to have_content("can't be blank")
    end
  end
end
