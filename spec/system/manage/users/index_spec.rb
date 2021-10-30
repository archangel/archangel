# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manage Users #index', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)
  end

  describe 'with results' do
    before do
      ('a'..'z').each do |letter|
        user = create(:user, username: "user-#{letter}")
        create(:user_site, user: user, site: site)
      end
    end

    describe 'with default sort order (`username` A-Z)' do
      before { visit '/manage/users' }

      it 'lists the first resource' do
        within('table.table tbody tr:nth-child(1)') do
          expect(page).to have_content('user-a')
        end
      end

      it 'does not list the first resource outside of pagination scope' do
        expect(page).not_to have_content('user-y')
      end
    end

    describe 'with paginated records' do
      it 'finds the second page of Users' do
        visit '/manage/users?page=2'

        expect(page).to have_content('user-y')
      end

      it 'does not find the first page of Users with `per` count' do
        visit '/manage/users?page=2&per=3'

        expect(page).not_to have_content('user-a')
      end

      it 'finds the second page of Users with `per` count' do
        visit '/manage/users?page=2&per=3'

        expect(page).to have_content('user-d')
      end

      it 'finds nothing outside the count' do
        visit '/manage/users?page=2&per=26'

        expect(page).to have_content('No users available')
      end
    end
  end

  describe 'without results' do
    it 'shows a message saying no records available' do
      visit '/manage/users'

      expect(page).to have_content('No users available')
    end
  end
end
