# frozen_string_literal: true

RSpec.describe 'Manage Collections #index', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)
  end

  describe 'with results' do
    before do
      ('A'..'Z').each { |letter| create(:collection, site: site, name: "Collection #{letter} Name") }
    end

    describe 'with default sort order (`name` A-Z)' do
      before { visit '/manage/collections' }

      it 'lists the first resource' do
        within('table.table tbody tr:nth-child(1)') do
          expect(page).to have_content('Collection A Name')
        end
      end

      it 'does not list the first resource outside of pagination scope' do
        expect(page).not_to have_content('Collection Y Name')
      end
    end

    describe 'with paginated records' do
      it 'finds the second page of Collections' do
        visit '/manage/collections?page=2'

        expect(page).to have_content('Collection Y Name')
      end

      it 'does not find the first page of Collections with `per` count' do
        visit '/manage/collections?page=2&per=3'

        expect(page).not_to have_content('Collection A Name')
      end

      it 'finds the second page of Collections with `per` count' do
        visit '/manage/collections?page=2&per=3'

        expect(page).to have_content('Collection D Name')
      end

      it 'finds nothing outside the count' do
        visit '/manage/collections?page=2&per=26'

        expect(page).to have_content('No collections available')
      end
    end

    describe 'includes' do
      before do
        create(:collection, :discarded, site: site, name: 'AAA - Discarded Collection Name')
      end

      it 'includes discarded Collections' do
        visit '/manage/collections'

        within('table.table tbody tr:nth-child(1)') do
          expect(page).to have_content('AAA - Discarded Collection Name')
        end
      end

      it 'marks discarded Collections' do
        visit '/manage/collections'

        expect(page).to have_css('table.table tbody tr:nth-child(1).status-deleted')
      end
    end
  end

  describe 'without results' do
    it 'shows a message saying no records available' do
      visit '/manage/collections'

      expect(page).to have_content('No collections available')
    end
  end
end
