# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manage Contents #index', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)
  end

  describe 'with results' do
    before do
      ('A'..'Z').each { |letter| create(:content, site: site, name: "Content #{letter} Name") }
    end

    describe 'with default sort order (`name` A-Z)' do
      before { visit '/manage/contents' }

      it 'lists the first resource' do
        within('table.table tbody tr:nth-child(1)') do
          expect(page).to have_content('Content A Name')
        end
      end

      it 'does not list the first resource outside of pagination scope' do
        expect(page).not_to have_content('Content Y Name')
      end
    end

    describe 'with paginated records' do
      it 'finds the second page of Contents' do
        visit '/manage/contents?page=2'

        expect(page).to have_content('Content Y Name')
      end

      it 'does not find the first page of Contents with `per` count' do
        visit '/manage/contents?page=2&per=3'

        expect(page).not_to have_content('Content A Name')
      end

      it 'finds the second page of Contents with `per` count' do
        visit '/manage/contents?page=2&per=3'

        expect(page).to have_content('Content D Name')
      end

      it 'finds nothing outside the count' do
        visit '/manage/contents?page=2&per=26'

        expect(page).to have_content('No contents available')
      end
    end

    describe 'includes' do
      before do
        create(:content, :discarded, site: site, name: 'AAA - Discarded Content Name')
      end

      it 'includes discarded Contents' do
        visit '/manage/contents'

        within('table.table tbody tr:nth-child(1)') do
          expect(page).to have_content('AAA - Discarded Content Name')
        end
      end

      it 'marks discarded Contents' do
        visit '/manage/contents'

        expect(page).to have_css('table.table tbody tr:nth-child(1).status-deleted')
      end
    end
  end

  describe 'without results' do
    it 'shows a message saying no records available' do
      visit '/manage/contents'

      expect(page).to have_content('No contents available')
    end
  end
end
