# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manage User #destroy', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)
  end

  describe 'when deleting' do
    let(:delete_user) { create(:user, username: 'delete-me') }
    let(:keep_user) { create(:user, username: 'keep-me') }

    before do
      create(:user_site, user: delete_user, site: site)
      create(:user_site, user: keep_user, site: site)

      visit '/manage/users'

      within(:css, 'table.table tbody tr:nth-child(1)') do
        click_on 'Delete User'
      end
    end

    it 'returns a success message' do

      expect(page).to have_content('User was successfully removed from this site.')
    end
  end
end
