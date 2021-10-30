# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manage User #show', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }
  let(:resource) { create(:user) }

  before do
    create(:user_site, user: profile, site: site)
    create(:user_site, user: resource, site: site)

    sign_in(profile)
  end

  describe 'when available' do
    before { visit "/manage/users/#{resource.id}" }

    it 'returns 200 status' do
      expect(page.status_code).to eq(200)
    end
  end

  describe 'when not available' do
    before { visit '/manage/users/0' }

    it 'returns 404 status' do
      expect(page.status_code).to eq(404)
    end

    it 'returns 404 when it does not exist' do
      expect(page).to have_content('Error 404')
    end
  end

  describe 'when viewing yourself' do
    before { visit "/manage/users/#{profile.id}" }

    it 'returns 404 status' do
      expect(page.status_code).to eq(404)
    end

    it 'returns 404 when it does not exist' do
      expect(page).to have_content('Error 404')
    end
  end
end
