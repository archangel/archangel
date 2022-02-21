# frozen_string_literal: true

RSpec.describe 'Switch Sites', type: :system, js: true do
  let(:site_a) { create(:site, name: 'First Site') }
  let(:site_b) { create(:site, name: 'Second Site') }
  let(:site_c) { create(:site, :discarded, name: 'Deleted Site') }
  let(:site_d) { create(:site, :discarded, name: 'Unassigned Site') }
  let(:profile) { create(:user) }

  before do
    create(:user_site, user: profile, site: site_a)
    create(:user_site, user: profile, site: site_b)
    create(:user_site, user: profile, site: site_c)

    sign_in(profile)
  end

  describe 'with first log in' do
    before { visit '/manage' }

    it 'returns first available Site' do
      within(:css, '#secondary-menu li:first-child a') do
        expect(page).to have_content('First Site')
      end
    end
  end

  describe 'with available Sites' do
    before { visit '/manage' }

    it 'does not list Sites that are not assigned to User' do
      within(:css, '#secondary-menu li:first-child') do
        click_link('First Site')

        expect(page).not_to have_content('Unassigned Site')
      end
    end

    it 'does not list Sites that are discarded' do
      within(:css, '#secondary-menu li:first-child') do
        click_link('First Site')

        expect(page).not_to have_content('Deleted Site')
      end
    end
  end

  describe 'when switching Sites' do
    before do
      visit '/manage'

      within(:css, '#secondary-menu li:first-child') do
        click_link('First Site')

        within(:css, 'ul.dropdown-menu') do
          click_link('Second Site')
        end
      end
    end

    it 'is successful' do
      within(:css, '#secondary-menu li:first-child a') do
        expect(page).to have_content('Second Site')
      end
    end
  end

  describe 'with no Sites assigned to User' do
    let(:alternative_user) { create(:user) }

    before do
      sign_in(alternative_user)

      visit '/manage'
    end

    it 'redirects to login' do
      expect(page).to have_current_path('/manage/login')
    end

    it 'returns a flash message' do
      expect(page).to have_content('No available sites assigned to you.')
    end
  end

  describe 'when Site access is removed from User while logged in' do
  end
end
