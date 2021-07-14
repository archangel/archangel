# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manage - Page #show', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  let(:resource) { create(:page, site: site) }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)
  end

  describe 'when available' do
    it 'returns 200 status' do
      visit "/manage/pages/#{resource.id}"

      expect(page.status_code).to eq 200
    end

    it 'returns success when resource is marked as discarded' do
      resource = create(:page, :discarded, site: site)

      visit "/manage/pages/#{resource.id}"

      expect(page.status_code).to eq 200
    end
  end

  # describe 'when not available' do
  #   it 'returns 404 status' do
  #     visit '/admin/pages/0'
  #
  #     expect(page.status_code).to eq 404
  #   end
  #
  #   it 'returns 404 when it does not exist' do
  #     visit '/admin/pages/0'
  #
  #     expect(page).to have_content('Error 404')
  #   end
  # end
end
