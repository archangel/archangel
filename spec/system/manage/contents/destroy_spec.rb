# frozen_string_literal: true

RSpec.describe 'Manage Content #destroy', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)
  end

  describe 'when deleting' do
    before do
      create(:content, site: site, name: 'Delete Me')
      create(:content, site: site, name: 'Keep Me')

      visit '/manage/contents'

      within(:css, 'table.table tbody tr:nth-child(1)') do
        click_on 'Delete Content'
      end
    end

    it 'returns a success message' do
      expect(page).to have_content('Content was successfully destroyed.')
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

  describe 'when destroying' do
    before do
      create(:content, :discarded, site: site, name: 'Delete Me')
      create(:content, site: site, name: 'Keep Me')

      visit '/manage/contents'

      within(:css, 'table.table tbody tr:nth-child(1)') do
        click_on 'Destroy Content'
      end
    end

    it 'returns a success message' do
      expect(page).to have_content('Content was successfully destroyed.')
    end

    it 'does not list destrayed resource' do
      within(:css, 'table.table tbody') do
        expect(page).not_to have_content('Destroy Me')
      end
    end
  end
end
