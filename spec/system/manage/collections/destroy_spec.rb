# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manage Collection #destroy', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)
  end

  describe 'when deleting' do
    before do
      create(:collection, site: site, name: 'Delete Me')
      create(:collection, site: site, name: 'Keep Me')

      visit '/manage/collections'

      within(:css, 'table.table tbody tr:nth-child(1)') do
        click_on 'Delete Collection'
      end
    end

    it 'returns a success message' do
      expect(page).to have_content('Collection was successfully destroyed.')
    end

    it 'still lists discarded resource' do
      within(:css, 'table.table tbody tr:nth-child(1)') do
        expect(page).to have_content('Delete Me')
      end
    end

    it 'has deleted style on discarded resource' do
      within(:css, 'table.table tbody') do
        expect(page).to have_css('tr:nth-child(1).status-deleted')
      end
    end
  end
end
