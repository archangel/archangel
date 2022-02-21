# frozen_string_literal: true

RSpec.describe 'Manage Profile #retoken', type: :system do
  let(:site) { create(:site) }
  let(:profile) { create(:user) }

  before do
    create(:user_site, user: profile, site: site)

    sign_in(profile)
  end

  it 'returns success message' do
    visit '/manage/profile'

    click_on 'Regenerate'

    expect(page).to have_content('Personal authentication token has been successfully regenerated.')
  end

  it 'generates a new token' do
    visit '/manage/profile'

    expect do
      click_on 'Regenerate'
      profile.reload
    end.to change(profile, :auth_token)
  end
end
